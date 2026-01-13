import 'dart:async';
import 'dart:convert';
import 'package:device_apps/device_apps.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:lockapp/src/constants/app_constants.dart';
import 'package:lockapp/src/types/app_control_models.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:usage_stats/usage_stats.dart';

class AppBlockingService {
  String get baseUrl => AppConstants.apiBaseUrl + '/api';

  // Cache for block rules
  List<AppBlockRule> _blockedApps = [];
  Timer? _monitoringTimer;
  Timer? _syncTimer;
  bool _isMonitoring = false;

  // Usage Tracking Buffer
  // Key: PackageName, Value: Seconds spent
  final Map<String, int> _usageBuffer = {};
  
  // Cache for App Names to avoid repetitive lookups
  final Map<String, String> _appNameCache = {};

  /// Check if Usage Stats permission is granted
  Future<bool> hasUsagePermission() async {
    return await UsageStats.checkUsagePermission() ?? false;
  }

  /// Request Usage Stats permission
  Future<void> requestUsagePermission() async {
    await UsageStats.grantUsagePermission();
  }

  /// Start monitoring running apps
  void startMonitoring(BuildContext context) {
    if (_isMonitoring) return;
    _isMonitoring = true;

    // Fetch rules immediately
    fetchBlockRules();

    // Refresh rules every minute
    Timer.periodic(const Duration(minutes: 1), (timer) {
      if (!_isMonitoring) timer.cancel();
      fetchBlockRules();
    });

    // Sync accumulated usage data to backend every 1 minute
    _syncTimer = Timer.periodic(const Duration(minutes: 1), (timer) async {
      if (!_isMonitoring) timer.cancel();
      await _syncUsageData();
    });

    // Monitor foreground app every 2 seconds
    _monitoringTimer = Timer.periodic(const Duration(seconds: 2), (timer) async {
      await _checkForegroundApp(context);
    });
  }

  /// Stop monitoring
  void stopMonitoring() {
    _monitoringTimer?.cancel();
    _syncTimer?.cancel();
    _isMonitoring = false;
    // Try to sync remaining data before stopping
    _syncUsageData(); 
  }

  /// Check current app, block if necessary, and track usage
  Future<void> _checkForegroundApp(BuildContext context) async {
    if (!(await hasUsagePermission())) return;

    try {
      DateTime endDate = DateTime.now();
      DateTime startDate = endDate.subtract(const Duration(seconds: 10));

      List<EventUsageInfo> events = await UsageStats.queryEvents(startDate, endDate);

      // Find the latest FOREGROUND event (Activity Resumed = 1)
      var latestEvent = events.lastWhere(
        (e) => e.eventType == '1', 
        orElse: () => EventUsageInfo(
            eventType: '0', 
            timeStamp: '0', 
            packageName: '', 
            className: ''
        ),
      );

      if (latestEvent.packageName != null && latestEvent.packageName!.isNotEmpty) {
        final currentPackage = latestEvent.packageName!;
        
        // --- USAGE TRACKING LOGIC ---
        // Increment usage buffer by 2 seconds (interval duration)
        _usageBuffer[currentPackage] = (_usageBuffer[currentPackage] ?? 0) + 2;
        
        // Resolve app name if not cached
        if (!_appNameCache.containsKey(currentPackage)) {
           // We use a fire-and-forget approach to resolve name
           _resolveAppName(currentPackage);
        }

        // --- BLOCKING LOGIC ---
        if (_blockedApps.isNotEmpty) {
          final isBlocked = _blockedApps.any((rule) => 
              rule.packageName == currentPackage && rule.isBlocked
          );

          if (isBlocked) {
            print("BLOCKED APP DETECTED: $currentPackage");
            // Log logic here or overlay trigger
          }
        }
      }
    } catch (e) {
      print("Error checking foreground app: $e");
    }
  }

  /// Resolve and cache app name
  Future<void> _resolveAppName(String packageName) async {
    try {
       // Check if it's a system app or installed app
       Application? app = await DeviceApps.getApp(packageName);
       if (app != null) {
         _appNameCache[packageName] = app.appName;
       } else {
         _appNameCache[packageName] = packageName; // Fallback
       }
    } catch (e) {
      _appNameCache[packageName] = packageName;
    }
  }

  /// Sync accumulated usage data to Backend
  Future<void> _syncUsageData() async {
    if (_usageBuffer.isEmpty) return;

    final user = await _getCurrentUser();
    if (user == null) return;

    // Create a copy to sync and clear the buffer immediately
    final Map<String, int> dataToSync = Map.from(_usageBuffer);
    _usageBuffer.clear();

    for (var entry in dataToSync.entries) {
      final packageName = entry.key;
      final seconds = entry.value;
      
      // Only sync if usage is significant (e.g., > 10 seconds) to reduce noise
      if (seconds < 10) continue; 
      
      final appName = _appNameCache[packageName] ?? packageName;
      final minutes = (seconds / 60).ceil(); // Convert to minutes, round up

      try {
        final url = Uri.parse('$baseUrl/usage');
        await http.post(
          url,
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode({
            'childUserId': int.parse(user.id),
            'appName': appName, // Sending real app name
            'usageMinutes': minutes,
            'appCategory': 'General', // TODO: Get category if possible
            'recordDate': DateTime.now().toIso8601String(),
          }),
        );
        print("Synced usage for $appName: $minutes min");
      } catch (e) {
        print("Error syncing usage for $packageName: $e");
        // Optional: Add back to buffer if failed? 
        // For now, simplicity: lose data rather than duplicate or complex retry.
      }
    }
  }

  /// Fetch block rules from Backend
  Future<void> fetchBlockRules() async {
    try {
      final user = await _getCurrentUser();
      if (user == null) return;

      final url = Uri.parse('$baseUrl/block-rules/${user.id}');
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        _blockedApps = data.map((json) => AppBlockRule.fromJson(json)).toList();
      }
    } catch (e) {
      print("Error fetching block rules: $e");
    }
  }

  /// Get installed apps using device_apps package
  Future<List<Map<String, dynamic>>> getInstalledApps() async {
    try {
      List<Application> apps = await DeviceApps.getInstalledApplications(
        includeAppIcons: true,
        includeSystemApps: false,
        onlyAppsWithLaunchIntent: true,
      );

      return apps.map((app) {
        String iconBase64 = '';
        if (app is ApplicationWithIcon) {
          iconBase64 = base64Encode(app.icon);
        }

        return {
          'packageName': app.packageName,
          'appName': app.appName,
          'appIcon': iconBase64,
        };
      }).toList();
    } catch (e) {
      print("Error getting installed apps: $e");
      return [];
    }
  }

  /// Toggle app block (Parent only)
  Future<AppBlockRule?> toggleAppBlock(String childId, String packageName, String appName, bool isBlocked) async {
    final user = await _getCurrentUser();
    if (user == null) return null;

    final url = Uri.parse('$baseUrl/block-rules');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'parentUserId': user.id,
        'childUserId': int.parse(childId),
        'packageName': packageName,
        'appName': appName,
        'isBlocked': isBlocked
      }),
    );

    if (response.statusCode == 200) {
      return AppBlockRule.fromJson(jsonDecode(response.body));
    }
    return null;
  }

  Future<dynamic> _getCurrentUser() async {
    final prefs = await SharedPreferences.getInstance();
    final userJson = prefs.getString('auth_user');
    if (userJson != null) {
      return jsonDecode(userJson);
    }
    return null;
  }
}