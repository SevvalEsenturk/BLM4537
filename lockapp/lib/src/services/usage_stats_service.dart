import 'package:lockapp/src/types/app_usage_stats.dart';
import 'dart:async';
import 'package:lockapp/src/mock/mock_data.dart'; // For mock users

class UsageStatsService {
  // In-memory storage for mock data
  static final List<AppUsageStats> _mockAppUsageStats = [];
  static final List<DailyUsageSummary> _mockDailyUsageSummaries = [];
  static final List<WeeklyUsageReport> _mockWeeklyUsageReports = [];

  /// Check if usage access permission is granted
  Future<bool> hasUsageStatsPermission() async {
    await Future.delayed(const Duration(milliseconds: 100));
    return true; // Always granted in mock
  }

  /// Request usage access permission
  Future<void> requestUsageStatsPermission() async {
    print('Mock UsageStatsService: requestUsageStatsPermission called');
    await Future.delayed(const Duration(milliseconds: 100));
  }

  /// Get usage stats for a specific date (mock data)
  Future<List<AppUsageStats>> getUsageStatsForDate(DateTime date) async {
    await Future.delayed(const Duration(milliseconds: 300));
    // Generate some mock data for the given date
    final String currentUserId = mockParentUser.id; // Use mock parent user ID
    final List<AppUsageStats> mockStats = [
      AppUsageStats(
        id: '${currentUserId}_com.instagram.android_${date.toIso8601String().split('T')[0]}',
        childUserId: currentUserId,
        packageName: 'com.instagram.android',
        appName: 'Instagram',
        appIcon: 'base64icon1',
        date: date,
        totalTimeInForeground: 120 * 60 * 1000, // 120 minutes
        launchCount: 15,
        firstTimeStamp: date.subtract(const Duration(hours: 2)),
        lastTimeStamp: date.subtract(const Duration(minutes: 10)),
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      ),
      AppUsageStats(
        id: '${currentUserId}_com.google.android.youtube_${date.toIso8601String().split('T')[0]}',
        childUserId: currentUserId,
        packageName: 'com.google.android.youtube',
        appName: 'YouTube',
        appIcon: 'base64icon2',
        date: date,
        totalTimeInForeground: 90 * 60 * 1000, // 90 minutes
        launchCount: 10,
        firstTimeStamp: date.subtract(const Duration(hours: 3)),
        lastTimeStamp: date.subtract(const Duration(minutes: 20)),
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      ),
    ];
    _mockAppUsageStats.addAll(mockStats);
    return mockStats;
  }

  /// Get usage stats for a date range (mock data)
  Future<List<AppUsageStats>> getUsageStatsForDateRange(DateTime startDate, DateTime endDate) async {
    await Future.delayed(const Duration(milliseconds: 500));
    // For simplicity, just return all mock stats within the range
    return _mockAppUsageStats.where((stats) =>
        stats.date.isAfter(startDate.subtract(const Duration(days: 1))) &&
        stats.date.isBefore(endDate.add(const Duration(days: 1)))).toList();
  }

  /// Sync usage stats to Firestore (mocked)
  Future<void> syncUsageStatsToFirestore(List<AppUsageStats> usageStats) async {
    await Future.delayed(const Duration(milliseconds: 500));
    print('Mock UsageStatsService: Synced ${usageStats.length} usage stats');
    // Add to in-memory storage
    _mockAppUsageStats.addAll(usageStats);
  }

  /// Get usage stats from Firestore (mocked)
  Future<List<AppUsageStats>> getUsageStatsFromFirestore({
    required String childUserId,
    required DateTime date,
  }) async {
    await Future.delayed(const Duration(milliseconds: 300));
    return _mockAppUsageStats.where((stats) =>
        stats.childUserId == childUserId &&
        stats.date.year == date.year &&
        stats.date.month == date.month &&
        stats.date.day == date.day).toList();
  }

  /// Generate daily usage summary (mocked)
  Future<DailyUsageSummary> generateDailyUsageSummary({
    required String childUserId,
    required DateTime date,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));
    final List<AppUsageStats> usageStats = await getUsageStatsForDate(date); // Use mock data

    if (usageStats.isEmpty) {
      return DailyUsageSummary(
        id: '${childUserId}_${date.toIso8601String().split('T')[0]}',
        childUserId: childUserId,
        date: date,
        totalScreenTime: 0,
        totalAppLaunches: 0,
        uniqueAppsUsed: 0,
        mostUsedApp: '',
        mostUsedAppTime: 0,
        topApps: [],
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );
    }

    final int totalScreenTime = usageStats.fold(0, (sum, stat) => sum + stat.totalTimeInForeground);
    final int totalAppLaunches = usageStats.fold(0, (sum, stat) => sum + stat.launchCount);
    final int uniqueAppsUsed = usageStats.length;
    final AppUsageStats mostUsedAppStats = usageStats.first;
    final String mostUsedApp = mostUsedAppStats.appName;
    final int mostUsedAppTime = mostUsedAppStats.totalTimeInForeground;
    final List<AppUsageStats> topApps = usageStats.take(10).toList();

    final DailyUsageSummary summary = DailyUsageSummary(
      id: '${childUserId}_${date.toIso8601String().split('T')[0]}',
      childUserId: childUserId,
      date: date,
      totalScreenTime: totalScreenTime,
      totalAppLaunches: totalAppLaunches,
      uniqueAppsUsed: uniqueAppsUsed,
      mostUsedApp: mostUsedApp,
      mostUsedAppTime: mostUsedAppTime,
      topApps: topApps,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
    _mockDailyUsageSummaries.add(summary);
    return summary;
  }

  /// Generate weekly usage report (mocked)
  Future<WeeklyUsageReport> generateWeeklyUsageReport({
    required String childUserId,
    required DateTime weekStart,
  }) async {
    await Future.delayed(const Duration(milliseconds: 800));
    final DateTime weekEnd = weekStart.add(const Duration(days: 6));
    final List<DailyUsageSummary> dailySummaries = [];

    for (int i = 0; i < 7; i++) {
      final DateTime currentDate = weekStart.add(Duration(days: i));
      dailySummaries.add(await generateDailyUsageSummary(childUserId: childUserId, date: currentDate));
    }

    final int totalScreenTime = dailySummaries.fold(0, (sum, summary) => sum + summary.totalScreenTime);
    final int averageDailyScreenTime = dailySummaries.isNotEmpty ? totalScreenTime ~/ dailySummaries.length : 0;
    final int totalAppLaunches = dailySummaries.fold(0, (sum, summary) => sum + summary.totalAppLaunches);
    final int averageDailyLaunches = dailySummaries.isNotEmpty ? totalAppLaunches ~/ dailySummaries.length : 0;

    final List<AppUsageStats> topAppsWeekly = []; // Simplified for mock

    final WeeklyUsageReport report = WeeklyUsageReport(
      id: '${childUserId}_${weekStart.toIso8601String().split('T')[0]}',
      childUserId: childUserId,
      weekStart: weekStart,
      weekEnd: weekEnd,
      totalScreenTime: totalScreenTime,
      averageDailyScreenTime: averageDailyScreenTime,
      totalAppLaunches: totalAppLaunches,
      averageDailyLaunches: averageDailyLaunches,
      dailySummaries: dailySummaries,
      topAppsWeekly: topAppsWeekly,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
    _mockWeeklyUsageReports.add(report);
    return report;
  }

  /// Auto-sync usage stats (mocked)
  Future<void> autoSyncUsageStats() async {
    print('Mock UsageStatsService: autoSyncUsageStats called');
    await Future.delayed(const Duration(seconds: 1));
    // Simulate syncing yesterday's stats
    final DateTime yesterday = DateTime.now().subtract(const Duration(days: 1));
    final List<AppUsageStats> usageStats = await getUsageStatsForDate(yesterday);
    if (usageStats.isNotEmpty) {
      await syncUsageStatsToFirestore(usageStats);
      await generateDailyUsageSummary(childUserId: mockParentUser.id, date: yesterday);
    }
  }
}