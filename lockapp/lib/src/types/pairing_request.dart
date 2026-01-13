import 'package:freezed_annotation/freezed_annotation.dart';


part 'pairing_request.freezed.dart';
part 'pairing_request.g.dart';

@freezed
class PairingRequest with _$PairingRequest {
  const factory PairingRequest({
    required String id,
    required String parentUserId,
    required String parentDeviceId,
    required String parentName,
    required String qrCode,
    required DateTime createdAt,
    required DateTime expiresAt,
    @Default(false) bool isUsed,
    String? childUserId,
    String? childDeviceId,
    String? childName,
    DateTime? acceptedAt,
  }) = _PairingRequest;

  const PairingRequest._();

  factory PairingRequest.fromJson(Map<String, dynamic> json) =>
      _$PairingRequestFromJson(json);

  
}

final PairingRequest emptyPairingRequest = PairingRequest(
  id: '',
  parentUserId: '',
  parentDeviceId: '',
  parentName: '',
  qrCode: '',
  createdAt: DateTime.now(),
  expiresAt: DateTime.now(),
); 