import 'package:freezed_annotation/freezed_annotation.dart';


part 'app_usage_stats.freezed.dart';
part 'app_usage_stats.g.dart';

@freezed
class AppUsageStats with _$AppUsageStats {
  const factory AppUsageStats({
    required String id,
    required String childUserId,
    required String packageName,
    required String appName,
    required String appIcon, // Base64 encoded icon
    required DateTime date,
    required int totalTimeInForeground, // milliseconds
    required int launchCount,
    required DateTime firstTimeStamp,
    required DateTime lastTimeStamp,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _AppUsageStats;

  const AppUsageStats._();

  factory AppUsageStats.fromJson(Map<String, dynamic> json) =>
      _$AppUsageStatsFromJson(json);

  Map<String, dynamic> toJson() => {
    'id': id,
    'childUserId': childUserId,
    'packageName': packageName,
    'appName': appName,
    'appIcon': appIcon,
    'date': date.toIso8601String(),
    'totalTimeInForeground': totalTimeInForeground,
    'launchCount': launchCount,
    'firstTimeStamp': firstTimeStamp.toIso8601String(),
    'lastTimeStamp': lastTimeStamp.toIso8601String(),
    'createdAt': createdAt.toIso8601String(),
    'updatedAt': updatedAt.toIso8601String(),
  };

  

  // Helper methods
  String get formattedDuration {
    final duration = Duration(milliseconds: totalTimeInForeground);
    final hours = duration.inHours;
    final minutes = duration.inMinutes % 60;
    final seconds = duration.inSeconds % 60;
    
    if (hours > 0) {
      return '${hours}s ${minutes}d ${seconds}s';
    } else if (minutes > 0) {
      return '${minutes}d ${seconds}s';
    } else {
      return '${seconds}s';
    }
  }

  double get usagePercentage {
    // Calculate percentage of day (24 hours = 86400000 ms)
    return (totalTimeInForeground / 86400000.0) * 100;
  }
}

@freezed
class DailyUsageSummary with _$DailyUsageSummary {
  const factory DailyUsageSummary({
    required String id,
    required String childUserId,
    required DateTime date,
    required int totalScreenTime, // milliseconds
    required int totalAppLaunches,
    required int uniqueAppsUsed,
    required String mostUsedApp,
    required int mostUsedAppTime,
    required List<AppUsageStats> topApps,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _DailyUsageSummary;

  const DailyUsageSummary._();

  factory DailyUsageSummary.fromJson(Map<String, dynamic> json) =>
      _$DailyUsageSummaryFromJson(json);

  Map<String, dynamic> toJson() => {
    'id': id,
    'childUserId': childUserId,
    'date': date.toIso8601String(),
    'totalScreenTime': totalScreenTime,
    'totalAppLaunches': totalAppLaunches,
    'uniqueAppsUsed': uniqueAppsUsed,
    'mostUsedApp': mostUsedApp,
    'mostUsedAppTime': mostUsedAppTime,
    'topApps': topApps.map((e) => e.toJson()).toList(),
    'createdAt': createdAt.toIso8601String(),
    'updatedAt': updatedAt.toIso8601String(),
  };

  

  // Helper methods
  String get formattedTotalScreenTime {
    final duration = Duration(milliseconds: totalScreenTime);
    final hours = duration.inHours;
    final minutes = duration.inMinutes % 60;
    
    if (hours > 0) {
      return '${hours}s ${minutes}d';
    } else {
      return '${minutes}d';
    }
  }
}

@freezed
class WeeklyUsageReport with _$WeeklyUsageReport {
  const factory WeeklyUsageReport({
    required String id,
    required String childUserId,
    required DateTime weekStart,
    required DateTime weekEnd,
    required int totalScreenTime, // milliseconds
    required int averageDailyScreenTime,
    required int totalAppLaunches,
    required int averageDailyLaunches,
    required List<DailyUsageSummary> dailySummaries,
    required List<AppUsageStats> topAppsWeekly,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _WeeklyUsageReport;

  const WeeklyUsageReport._();

  factory WeeklyUsageReport.fromJson(Map<String, dynamic> json) =>
      _$WeeklyUsageReportFromJson(json);

  Map<String, dynamic> toJson() => {
    'id': id,
    'childUserId': childUserId,
    'weekStart': weekStart.toIso8601String(),
    'weekEnd': weekEnd.toIso8601String(),
    'totalScreenTime': totalScreenTime,
    'averageDailyScreenTime': averageDailyScreenTime,
    'totalAppLaunches': totalAppLaunches,
    'averageDailyLaunches': averageDailyLaunches,
    'dailySummaries': dailySummaries.map((e) => e.toJson()).toList(),
    'topAppsWeekly': topAppsWeekly.map((e) => e.toJson()).toList(),
    'createdAt': createdAt.toIso8601String(),
    'updatedAt': updatedAt.toIso8601String(),
  };

  
} 