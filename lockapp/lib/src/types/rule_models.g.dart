// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rule_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TimeRuleImpl _$$TimeRuleImplFromJson(Map<String, dynamic> json) =>
    _$TimeRuleImpl(
      id: (json['id'] as num).toInt(),
      childUserId: (json['childUserId'] as num).toInt(),
      dailyLimitMinutes: (json['dailyLimitMinutes'] as num).toInt(),
      allowedWindowStart: json['allowedWindowStart'] == null
          ? null
          : Duration(microseconds: (json['allowedWindowStart'] as num).toInt()),
      allowedWindowEnd: json['allowedWindowEnd'] == null
          ? null
          : Duration(microseconds: (json['allowedWindowEnd'] as num).toInt()),
      activeDaysJson: json['activeDaysJson'] as String?,
      exceptionsJson: json['exceptionsJson'] as String?,
      isActive: json['isActive'] as bool,
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$$TimeRuleImplToJson(_$TimeRuleImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'childUserId': instance.childUserId,
      'dailyLimitMinutes': instance.dailyLimitMinutes,
      'allowedWindowStart': instance.allowedWindowStart?.inMicroseconds,
      'allowedWindowEnd': instance.allowedWindowEnd?.inMicroseconds,
      'activeDaysJson': instance.activeDaysJson,
      'exceptionsJson': instance.exceptionsJson,
      'isActive': instance.isActive,
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };
