// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pairing_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PairingRequestImpl _$$PairingRequestImplFromJson(Map<String, dynamic> json) =>
    _$PairingRequestImpl(
      id: (json['id'] as num).toInt(),
      parentUserId: (json['parentUserId'] as num).toInt(),
      childUserId: (json['childUserId'] as num).toInt(),
      pairingCode: json['pairingCode'] as String,
      deviceName: json['deviceName'] as String,
      deviceType: json['deviceType'] as String,
      status: json['status'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      expiresAt: json['expiresAt'] == null
          ? null
          : DateTime.parse(json['expiresAt'] as String),
      approvedAt: json['approvedAt'] == null
          ? null
          : DateTime.parse(json['approvedAt'] as String),
      childName: json['childName'] as String?,
    );

Map<String, dynamic> _$$PairingRequestImplToJson(
        _$PairingRequestImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'parentUserId': instance.parentUserId,
      'childUserId': instance.childUserId,
      'pairingCode': instance.pairingCode,
      'deviceName': instance.deviceName,
      'deviceType': instance.deviceType,
      'status': instance.status,
      'createdAt': instance.createdAt.toIso8601String(),
      'expiresAt': instance.expiresAt?.toIso8601String(),
      'approvedAt': instance.approvedAt?.toIso8601String(),
      'childName': instance.childName,
    };

_$PairingCodeImpl _$$PairingCodeImplFromJson(Map<String, dynamic> json) =>
    _$PairingCodeImpl(
      code: json['code'] as String,
      expiresAt: DateTime.parse(json['expiresAt'] as String),
      message: json['message'] as String?,
    );

Map<String, dynamic> _$$PairingCodeImplToJson(_$PairingCodeImpl instance) =>
    <String, dynamic>{
      'code': instance.code,
      'expiresAt': instance.expiresAt.toIso8601String(),
      'message': instance.message,
    };
