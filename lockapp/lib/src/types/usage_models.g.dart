// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'usage_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UsageRecordImpl _$$UsageRecordImplFromJson(Map<String, dynamic> json) =>
    _$UsageRecordImpl(
      id: (json['id'] as num).toInt(),
      childUserId: (json['childUserId'] as num).toInt(),
      appName: json['appName'] as String,
      usageMinutes: (json['usageMinutes'] as num).toInt(),
      appCategory: json['appCategory'] as String?,
      recordDate: DateTime.parse(json['recordDate'] as String),
    );

Map<String, dynamic> _$$UsageRecordImplToJson(_$UsageRecordImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'childUserId': instance.childUserId,
      'appName': instance.appName,
      'usageMinutes': instance.usageMinutes,
      'appCategory': instance.appCategory,
      'recordDate': instance.recordDate.toIso8601String(),
    };

_$UsageSummaryImpl _$$UsageSummaryImplFromJson(Map<String, dynamic> json) =>
    _$UsageSummaryImpl(
      childId: (json['childId'] as num).toInt(),
      range: json['range'] as String,
      totalMinutes: (json['totalMinutes'] as num).toInt(),
      startDate: DateTime.parse(json['startDate'] as String),
      endDate: DateTime.parse(json['endDate'] as String),
    );

Map<String, dynamic> _$$UsageSummaryImplToJson(_$UsageSummaryImpl instance) =>
    <String, dynamic>{
      'childId': instance.childId,
      'range': instance.range,
      'totalMinutes': instance.totalMinutes,
      'startDate': instance.startDate.toIso8601String(),
      'endDate': instance.endDate.toIso8601String(),
    };

_$TopAppImpl _$$TopAppImplFromJson(Map<String, dynamic> json) => _$TopAppImpl(
      appName: json['appName'] as String,
      totalMinutes: (json['totalMinutes'] as num).toInt(),
      category: json['category'] as String?,
    );

Map<String, dynamic> _$$TopAppImplToJson(_$TopAppImpl instance) =>
    <String, dynamic>{
      'appName': instance.appName,
      'totalMinutes': instance.totalMinutes,
      'category': instance.category,
    };
