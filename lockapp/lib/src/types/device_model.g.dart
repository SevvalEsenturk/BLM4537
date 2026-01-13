// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'device_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DeviceModel _$DeviceModelFromJson(Map<String, dynamic> json) => DeviceModel(
      id: json['id'] as String,
      userId: json['user_id'] as String,
      deviceName: json['device_name'] as String,
      deviceId: json['device_id'] as String,
      deviceType: $enumDecode(_$DeviceTypeEnumMap, json['device_type']),
      status: $enumDecode(_$DeviceStatusEnumMap, json['status']),
      osVersion: json['os_version'] as String?,
      appVersion: json['app_version'] as String?,
      deviceModel: json['device_model'] as String?,
      isOnline: json['is_online'] as bool? ?? false,
      lastSeen: DateTime.parse(json['lastSeen'] as String),
      fcmToken: json['fcm_token'] as String?,
      settings: json['settings'] as Map<String, dynamic>?,
      metadata: json['metadata'] as Map<String, dynamic>?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$DeviceModelToJson(DeviceModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user_id': instance.userId,
      'device_name': instance.deviceName,
      'device_id': instance.deviceId,
      'device_type': _$DeviceTypeEnumMap[instance.deviceType]!,
      'status': _$DeviceStatusEnumMap[instance.status]!,
      'os_version': instance.osVersion,
      'app_version': instance.appVersion,
      'device_model': instance.deviceModel,
      'is_online': instance.isOnline,
      'lastSeen': instance.lastSeen.toIso8601String(),
      'fcm_token': instance.fcmToken,
      'settings': instance.settings,
      'metadata': instance.metadata,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
    };

const _$DeviceTypeEnumMap = {
  DeviceType.parentDevice: 'parent_device',
  DeviceType.childDevice: 'child_device',
};

const _$DeviceStatusEnumMap = {
  DeviceStatus.active: 'active',
  DeviceStatus.inactive: 'inactive',
  DeviceStatus.blocked: 'blocked',
  DeviceStatus.pending: 'pending',
};
