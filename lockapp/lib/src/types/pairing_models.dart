import 'package:freezed_annotation/freezed_annotation.dart';

part 'pairing_models.freezed.dart';
part 'pairing_models.g.dart';

@freezed
class PairingRequest with _$PairingRequest {
  const factory PairingRequest({
    required int id,
    required int parentUserId,
    required int childUserId,
    required String pairingCode,
    required String deviceName,
    required String deviceType,
    required String status,
    required DateTime createdAt,
    DateTime? expiresAt,
    DateTime? approvedAt,
    String? childName,
  }) = _PairingRequest;

  factory PairingRequest.fromJson(Map<String, dynamic> json) =>
      _$PairingRequestFromJson(json);
}

@freezed
class PairingCode with _$PairingCode {
  const factory PairingCode({
    required String code,
    required DateTime expiresAt,
    String? message,
  }) = _PairingCode;

  factory PairingCode.fromJson(Map<String, dynamic> json) =>
      _$PairingCodeFromJson(json);
}
