import 'dart:math';
import 'package:lockapp/src/types/pairing_request.dart';
import 'package:lockapp/src/types/user_model.dart';
import 'package:lockapp/src/types/device_model.dart';
import 'package:lockapp/src/types/enums/user_role.dart';
import 'package:lockapp/src/mock/mock_data.dart';
import 'dart:async';

class QrPairingService {
  // In-memory storage for mock data
  static final List<PairingRequest> _mockPairingRequests = [];

  /// Generate QR code for parent device
  Future<PairingRequest> generatePairingRequest({
    required String parentName,
    required String parentDeviceId,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));
    final qrCode = _generateQrCode();
    final pairingRequest = PairingRequest(
      id: 'mock_pairing_req_${DateTime.now().millisecondsSinceEpoch}',
      parentUserId: mockParentUser.id, // Use mock parent user ID
      parentDeviceId: parentDeviceId,
      parentName: parentName,
      qrCode: qrCode,
      createdAt: DateTime.now(),
      expiresAt: DateTime.now().add(const Duration(hours: 24)),
    );
    _mockPairingRequests.add(pairingRequest);
    print('Mock: Generated pairing request with QR code: ${pairingRequest.qrCode}');
    return pairingRequest;
  }

  /// Scan QR code and create child account
  Future<UserModel?> acceptPairingRequest(String qrCode, String childName) async {
    await Future.delayed(const Duration(seconds: 1));
    PairingRequest? pairingRequest;
    try {
      pairingRequest = _mockPairingRequests.firstWhere(
        (req) => req.qrCode == qrCode && !req.isUsed && req.expiresAt.isAfter(DateTime.now()),
      );
    } catch (e) {
      throw Exception('QR kod geçersiz veya süresi dolmuş');
    }

    // Simulate creating child user and device
    final childUser = UserModel(
      id: 'mock_child_${DateTime.now().millisecondsSinceEpoch}',
      email: '$childName@mock.com',
      name: childName,
      role: UserRole.child,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      isActive: true,
      parentUserId: pairingRequest.parentUserId,
    );

    final childDevice = DeviceModel(
      id: 'mock_child_device_${DateTime.now().millisecondsSinceEpoch}',
      userId: childUser.id,
      deviceName: '$childName\'s Device',
      deviceId: 'mock_child_device_id_${DateTime.now().millisecondsSinceEpoch}',
      deviceType: DeviceType.childDevice,
      status: DeviceStatus.active,
      lastSeen: DateTime.now(),
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );

    // Update mock data
    final updatedPairingRequest = pairingRequest.copyWith(
      isUsed: true,
      childUserId: childUser.id,
      childDeviceId: childDevice.id,
      childName: childName,
      acceptedAt: DateTime.now(),
    );
    final index = _mockPairingRequests.indexOf(pairingRequest);
    if (index != -1) {
      _mockPairingRequests[index] = updatedPairingRequest;
    }

    mockUsers.add(childUser);
    mockDevices.add(childDevice);

    print('Mock: Accepted pairing request for child: $childName');
    return childUser;
  }

  /// Get active pairing requests for current user
  Future<List<PairingRequest>> getActivePairingRequests() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return _mockPairingRequests
        .where((req) => req.parentUserId == mockParentUser.id && !req.isUsed && req.expiresAt.isAfter(DateTime.now()))
        .toList();
  }

  /// Delete pairing request
  Future<void> deletePairingRequest(String requestId) async {
    await Future.delayed(const Duration(milliseconds: 500));
    _mockPairingRequests.removeWhere((req) => req.id == requestId);
    print('Mock: Deleted pairing request: $requestId');
  }

  /// Generate unique QR code
  String _generateQrCode() {
    const chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    final random = Random();
    return List.generate(8, (index) => chars[random.nextInt(chars.length)]).join();
  }

  /// Clean up expired pairing requests
  Future<void> cleanupExpiredRequests() async {
    await Future.delayed(const Duration(milliseconds: 200));
    _mockPairingRequests.removeWhere((req) => req.expiresAt.isBefore(DateTime.now()));
    print('Mock: Cleaned up expired pairing requests');
  }
}