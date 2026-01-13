import 'package:freezed_annotation/freezed_annotation.dart';

part 'usage_models.freezed.dart';
part 'usage_models.g.dart';

@freezed
class UsageRecord with _$UsageRecord {
  const factory UsageRecord({
    required int id,
    required int childUserId,
    required String appName,
    required int usageMinutes,
    String? appCategory,
    required DateTime recordDate,
  }) = _UsageRecord;

  factory UsageRecord.fromJson(Map<String, dynamic> json) =>
      _$UsageRecordFromJson(json);
}

@freezed
class UsageSummary with _$UsageSummary {
  const factory UsageSummary({
    required int childId,
    required String range,
    required int totalMinutes,
    required DateTime startDate,
    required DateTime endDate,
  }) = _UsageSummary;

  factory UsageSummary.fromJson(Map<String, dynamic> json) =>
      _$UsageSummaryFromJson(json);
}

@freezed
class TopApp with _$TopApp {
  const factory TopApp({
    required String appName,
    required int totalMinutes,
    String? category,
  }) = _TopApp;

  factory TopApp.fromJson(Map<String, dynamic> json) =>
      _$TopAppFromJson(json);
}
