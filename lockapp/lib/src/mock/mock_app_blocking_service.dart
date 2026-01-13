import 'dart:async';
import 'package:lockapp/src/types/app_control_models.dart';

class MockAppBlockingService {
  // In-memory storage for mock data
  static final List<AppBlockRule> _mockBlockRules = <AppBlockRule>[];
  static final List<BlockAttemptLog> _mockBlockAttemptLogs =
      <BlockAttemptLog>[];

  // Check if app has device admin permissions
  Future<bool> hasDeviceAdminPermission() async {
    await Future.delayed(const Duration(milliseconds: 100));
    return true; // Always granted in mock
  }

  // Request device admin permissions
  Future<bool> requestDeviceAdminPermission() async {
    await Future.delayed(const Duration(milliseconds: 100));
    return true; // Always granted in mock
  }

  // Block an app
  Future<bool> blockApp(String packageName) async {
    await Future.delayed(const Duration(milliseconds: 100));
    print('Mock: Blocking app $packageName');
    return true; // Always successful in mock
  }

  // Unblock an app
  Future<bool> unblockApp(String packageName) async {
    await Future.delayed(const Duration(milliseconds: 100));
    print('Mock: Unblocking app $packageName');
    return true; // Always successful in mock
  }

  // Get list of installed apps (mock data)
  Future<List<Map<String, dynamic>>> getInstalledApps() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return [
      {
        'packageName': 'com.instagram.android',
        'appName': 'Instagram',
        'appIcon': 'base64icon1'
      },
      {
        'packageName': 'com.facebook.katana',
        'appName': 'Facebook',
        'appIcon': 'base64icon2'
      },
      {
        'packageName': 'com.whatsapp',
        'appName': 'WhatsApp',
        'appIcon': 'base64icon3'
      },
      {
        'packageName': 'com.google.android.youtube',
        'appName': 'YouTube',
        'appIcon': 'base64icon4'
      },
      {
        'packageName': 'com.spotify.music',
        'appName': 'Spotify',
        'appIcon': 'base64icon5'
      },
    ];
  }

  // Create or update app block rule
  Future<AppBlockRule> createBlockRule({
    required String parentUserId,
    required String childUserId,
    required String packageName,
    required String appName,
    required String appIcon,
    required bool isBlocked,
    String? reason,
    DateTime? blockedUntil,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));

    final newRule = AppBlockRule(
      id: 'mock_rule_${DateTime.now().millisecondsSinceEpoch}',
      parentUserId: parentUserId,
      childUserId: childUserId,
      packageName: packageName,
      appName: appName,
      appIcon: appIcon,
      isBlocked: isBlocked,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      reason: reason,
      blockedUntil: blockedUntil,
    );

    _mockBlockRules.add(newRule);
    print('Mock: Created block rule for ${newRule.appName}');
    return newRule;
  }

  // Get block rules for a child
  Future<List<AppBlockRule>> getBlockRules({
    required String childUserId,
  }) async {
    await Future.delayed(const Duration(milliseconds: 300));
    return _mockBlockRules
        .where((rule) => rule.childUserId == childUserId)
        .toList();
  }

  // Update block rule
  Future<AppBlockRule> updateBlockRule({
    required String ruleId,
    required bool isBlocked,
    String? reason,
    DateTime? blockedUntil,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));

    final index = _mockBlockRules.indexWhere((rule) => rule.id == ruleId);
    if (index != -1) {
      final existing = _mockBlockRules[index];

      final updatedRule = AppBlockRule(
        id: existing.id,
        parentUserId: existing.parentUserId,
        childUserId: existing.childUserId,
        packageName: existing.packageName,
        appName: existing.appName,
        appIcon: existing.appIcon,
        isBlocked: isBlocked,
        createdAt: existing.createdAt,
        updatedAt: DateTime.now(),
        reason: reason ?? existing.reason,
        blockedUntil: blockedUntil ?? existing.blockedUntil,
      );

      _mockBlockRules[index] = updatedRule;
      print('Mock: Updated block rule for ${updatedRule.appName}');
      return updatedRule;
    }

    throw Exception('Mock: Block rule not found');
  }

  // Delete block rule
  Future<void> deleteBlockRule(String ruleId) async {
    await Future.delayed(const Duration(milliseconds: 500));
    _mockBlockRules.removeWhere((rule) => rule.id == ruleId);
    print('Mock: Deleted block rule $ruleId');
  }

  // Log block attempt
  Future<void> logBlockAttempt({
    required String childUserId,
    required String packageName,
    required String appName,
    required String blockReason,
    required bool wasBlocked,
  }) async {
    await Future.delayed(const Duration(milliseconds: 200));

    final log = BlockAttemptLog(
      id: 'mock_log_${DateTime.now().millisecondsSinceEpoch}',
      childUserId: childUserId,
      packageName: packageName,
      appName: appName,
      attemptTime: DateTime.now(),
      blockReason: blockReason,
      wasBlocked: wasBlocked,
      createdAt: DateTime.now(),
    );

    _mockBlockAttemptLogs.add(log);
    print('Mock: Logged block attempt for ${log.appName}');
  }

  // Get block attempt logs
  Future<List<BlockAttemptLog>> getBlockAttemptLogs({
    required String childUserId,
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    await Future.delayed(const Duration(milliseconds: 300));

    return _mockBlockAttemptLogs.where((log) {
      if (log.childUserId != childUserId) return false;

      if (startDate != null && !log.attemptTime.isAfter(startDate)) {
        return false;
      }

      if (endDate != null && !log.attemptTime.isBefore(endDate)) {
        return false;
      }

      return true;
    }).toList();
  }

  // Generate app control summary
  Future<AppControlSummary> generateAppControlSummary({
    required String childUserId,
    required DateTime date,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));
    final now = DateTime.now();

    final blockedApps = _mockBlockRules.where((rule) {
      if (rule.childUserId != childUserId) return false;

      // Determine current blocked state using fields rather than a helper property
      if (!rule.isBlocked) return false;

      final until = rule.blockedUntil;
      if (until == null) return true;

      return until.isAfter(now);
    }).toList();

    final blockAttempts = _mockBlockAttemptLogs.where((log) {
      if (log.childUserId != childUserId) return false;

      return log.attemptTime.year == date.year &&
          log.attemptTime.month == date.month &&
          log.attemptTime.day == date.day;
    }).toList();

    final Map<String, int> appBlockCounts = <String, int>{};
    for (final attempt in blockAttempts) {
      appBlockCounts[attempt.packageName] =
          (appBlockCounts[attempt.packageName] ?? 0) + 1;
    }

    final mostBlockedApps = appBlockCounts.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));

    return AppControlSummary(
      id: 'mock_summary_${DateTime.now().millisecondsSinceEpoch}',
      childUserId: childUserId,
      date: date,
      totalBlockedApps: blockedApps.length,
      totalTimeRestrictedApps: 0, // Mocked
      totalBlockAttempts: blockAttempts.length,
      mostBlockedApps: mostBlockedApps.take(5).map((e) => e.key).toList(),
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
  }

  // Sync block rules to device
  Future<void> syncBlockRulesToDevice({
    required String childUserId,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));
    print('Mock: Syncing block rules to device for $childUserId');
  }
}
