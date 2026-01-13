import 'package:lockapp/src/types/app_control_models.dart';
import 'dart:async';

class TimeRestrictionService {
  // In-memory storage for mock data
  static final List<TimeRestriction> _mockTimeRestrictions = [];

  /// Check if time restrictions are enabled
  Future<bool> hasTimeRestrictions() async {
    await Future.delayed(const Duration(milliseconds: 100));
    return _mockTimeRestrictions.isNotEmpty;
  }

  /// Get all active time restrictions for a child
  Future<List<TimeRestriction>> getActiveTimeRestrictions({
    String? childUserId,
  }) async {
    await Future.delayed(const Duration(milliseconds: 300));
    return _mockTimeRestrictions
        .where((tr) => tr.isEnabled && (childUserId == null || tr.childUserId == childUserId))
        .toList();
  }

  /// Create or update a time restriction
  Future<TimeRestriction> createOrUpdateTimeRestriction({
    required String parentUserId,
    required String childUserId,
    required String packageName,
    required String appName,
    required int dailyTimeLimit, // in minutes
    required List<int> allowedDays, // 0-6 (Sunday-Saturday)
    required String startTime, // HH:mm format
    required String endTime, // HH:mm format
    bool isEnabled = true,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));
    final newRestriction = TimeRestriction(
      id: '${childUserId}_${packageName}_restriction',
      parentUserId: parentUserId,
      childUserId: childUserId,
      packageName: packageName,
      appName: appName,
      appIcon: '', // Mocked
      isEnabled: isEnabled,
      dailyTimeLimit: dailyTimeLimit,
      allowedDays: allowedDays,
      startTime: startTime,
      endTime: endTime,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );

    final index = _mockTimeRestrictions.indexWhere((tr) => tr.id == newRestriction.id);
    if (index != -1) {
      _mockTimeRestrictions[index] = newRestriction;
      print('Mock: Updated time restriction for ${newRestriction.appName}');
    } else {
      _mockTimeRestrictions.add(newRestriction);
      print('Mock: Created time restriction for ${newRestriction.appName}');
    }
    return newRestriction;
  }

  /// Get time restrictions for a specific app
  Future<List<TimeRestriction>> getAppTimeRestrictions({
    required String childUserId,
    required String packageName,
  }) async {
    await Future.delayed(const Duration(milliseconds: 300));
    return _mockTimeRestrictions
        .where((tr) => tr.childUserId == childUserId && tr.packageName == packageName)
        .toList();
  }

  /// Check if an app is currently restricted
  Future<bool> isAppCurrentlyRestricted({
    required String childUserId,
    required String packageName,
  }) async {
    await Future.delayed(const Duration(milliseconds: 200));
    final restrictions = await getAppTimeRestrictions(
      childUserId: childUserId,
      packageName: packageName,
    );

    final now = DateTime.now();
    int currentDay;
    if (now.weekday == 7) {
      currentDay = 0; // Sunday
    } else {
      currentDay = now.weekday; // Monday=1, Tuesday=2, etc.s
    }
    final currentTime = '${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}';

    for (final restriction in restrictions) {
      if (!restriction.isEnabled) continue;

      if (!restriction.allowedDays.contains(currentDay)) {
        return true;
      }

      if (!_isTimeInRange(currentTime, restriction.startTime, restriction.endTime)) {
        return true;
      }
    }
    return false;
  }

  /// Delete a time restriction
  Future<void> deleteTimeRestriction(String restrictionId) async {
    await Future.delayed(const Duration(milliseconds: 500));
    _mockTimeRestrictions.removeWhere((tr) => tr.id == restrictionId);
    print('Mock: Deleted time restriction: $restrictionId');
  }

  /// Toggle time restriction enabled/disabled
  Future<void> toggleTimeRestriction(String restrictionId, bool isEnabled) async {
    await Future.delayed(const Duration(milliseconds: 500));
    final index = _mockTimeRestrictions.indexWhere((tr) => tr.id == restrictionId);
    if (index != -1) {
      _mockTimeRestrictions[index] = _mockTimeRestrictions[index].copyWith(
        isEnabled: isEnabled,
        updatedAt: DateTime.now(),
      );
      print('Mock: Toggled time restriction $restrictionId to $isEnabled');
    }
  }

  /// Get time restriction summary for a child
  Future<Map<String, dynamic>> getTimeRestrictionSummary({
    required String childUserId,
  }) async {
    await Future.delayed(const Duration(milliseconds: 300));
    final restrictions = await getActiveTimeRestrictions(childUserId: childUserId);

    final totalRestrictions = restrictions.length;
    final activeRestrictions = restrictions.where((r) => r.isEnabled).length;
    final restrictedApps = restrictions.map((r) => r.appName).toSet().length;

    return {
      'totalRestrictions': totalRestrictions,
      'activeRestrictions': activeRestrictions,
      'restrictedApps': restrictedApps,
      'restrictions': restrictions,
    };
  }

  /// Check if current time is within allowed range
  bool _isTimeInRange(String currentTime, String startTime, String endTime) {
    final current = _parseTime(currentTime);
    final start = _parseTime(startTime);
    final end = _parseTime(endTime);

    if (start <= end) {
      // Same day range (e.g., 09:00 - 17:00)
      return current >= start && current <= end;
    } else {
      // Overnight range (e.g., 22:00 - 06:00)
      return current >= start || current <= end;
    }
  }

  /// Parse time string to minutes since midnight
  int _parseTime(String time) {
    final parts = time.split(':');
    final hours = int.parse(parts[0]);
    final minutes = int.parse(parts[1]);
    return hours * 60 + minutes;
  }
}