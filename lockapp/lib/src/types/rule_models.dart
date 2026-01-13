import 'package:freezed_annotation/freezed_annotation.dart';

part 'rule_models.freezed.dart';
part 'rule_models.g.dart';

@freezed
class TimeRule with _$TimeRule {
  const factory TimeRule({
    required int id,
    required int childUserId,
    required int dailyLimitMinutes,
    Duration? allowedWindowStart,
    Duration? allowedWindowEnd,
    String? activeDaysJson,
    String? exceptionsJson,
    required bool isActive,
    DateTime? updatedAt,
  }) = _TimeRule;

  factory TimeRule.fromJson(Map<String, dynamic> json) =>
      _$TimeRuleFromJson(json);
}
