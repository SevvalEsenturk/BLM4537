import 'dart:async';
import 'package:lockapp/src/types/user_model.dart';
import 'package:lockapp/src/types/device_model.dart';
import 'package:lockapp/src/types/enums/user_role.dart';
import 'package:lockapp/src/mock/mock_data.dart';

class MockFirestoreService {
  /// Simulate a logged-in parent
  static String? get currentUserId => mockParentUser.id;

  // Küçük yardımcı: firstWhereOrNull
  static T? _firstWhereOrNull<T>(
    Iterable<T> items,
    bool Function(T item) test,
  ) {
    for (final item in items) {
      if (test(item)) return item;
    }
    return null;
  }

  // ===== USER OPERATIONS =====

  static Future<void> createUser(UserModel user) async {
    await Future.delayed(const Duration(milliseconds: 500));
    mockUsers.add(user);
  }

  static Future<UserModel?> getUser(String userId) async {
    await Future.delayed(const Duration(milliseconds: 200));
    return _firstWhereOrNull<UserModel>(
      mockUsers,
      (user) => user.id == userId,
    );
  }

  static Future<void> updateUser(
    String userId,
    Map<String, dynamic> updates,
  ) async {
    await Future.delayed(const Duration(milliseconds: 500));

    final index = mockUsers.indexWhere((user) => user.id == userId);
    if (index != -1) {
      final current = mockUsers[index];
      mockUsers[index] = current.copyWith(
        name: updates['name'] ?? current.name,
        profileImageUrl:
            updates['profile_image_url'] ?? current.profileImageUrl,
        updatedAt: DateTime.now(),
      );
    }
  }

  static Future<List<UserModel>> getUsersByRole(UserRole role) async {
    await Future.delayed(const Duration(milliseconds: 300));
    return mockUsers
        .where((user) => user.role == role && user.isActive)
        .toList();
  }

  // ===== DEVICE OPERATIONS =====

  static Future<String> createDevice(DeviceModel device) async {
    await Future.delayed(const Duration(milliseconds: 500));

    final newDevice = device.copyWith(
      id: 'mock_device_${DateTime.now().millisecondsSinceEpoch}',
    );
    mockDevices.add(newDevice);
    return newDevice.id;
  }

  static Future<DeviceModel?> getDevice(String deviceId) async {
    await Future.delayed(const Duration(milliseconds: 200));
    return _firstWhereOrNull<DeviceModel>(
      mockDevices,
      (device) => device.id == deviceId,
    );
  }

  static Future<List<DeviceModel>> getUserDevices(String userId) async {
    await Future.delayed(const Duration(milliseconds: 300));
    return mockDevices.where((device) => device.userId == userId).toList();
  }

  static Future<void> updateDevice(
    String deviceId,
    Map<String, dynamic> updates,
  ) async {
    await Future.delayed(const Duration(milliseconds: 500));

    final index = mockDevices.indexWhere((device) => device.id == deviceId);
    if (index != -1) {
      final current = mockDevices[index];

      mockDevices[index] = current.copyWith(
        deviceName: updates['device_name'] ?? current.deviceName,
        status: updates['status'] != null
            ? DeviceStatusExtension.fromString(updates['status'])
            : current.status,
        isOnline: updates['is_online'] ?? current.isOnline,
        lastSeen: updates['last_seen'] ?? current.lastSeen,
        updatedAt: DateTime.now(),
      );
    }
  }

  static Future<void> updateDeviceOnlineStatus(
    String deviceId,
    bool isOnline,
  ) async {
    await updateDevice(deviceId, {
      'is_online': isOnline,
      'last_seen': DateTime.now(),
    });
  }

  static Future<void> deleteDevice(String deviceId) async {
    await Future.delayed(const Duration(milliseconds: 500));
    mockDevices.removeWhere((device) => device.id == deviceId);
  }

  static Future<DeviceModel?> getDeviceByDeviceId(String deviceId) async {
    await Future.delayed(const Duration(milliseconds: 200));
    return _firstWhereOrNull<DeviceModel>(
      mockDevices,
      (device) => device.deviceId == deviceId,
    );
  }

  // ===== DEVICE PAIRING OPERATIONS (Simplified) =====

  static Future<String> createDevicePairing({
    required String parentDeviceId,
    required String childDeviceId,
    required String parentUserId,
    required String childUserId,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return 'mock_pairing_${DateTime.now().millisecondsSinceEpoch}';
  }

  static Future<List<Map<String, dynamic>>> getDevicePairings(
    String userId,
  ) async {
    await Future.delayed(const Duration(milliseconds: 300));
    return []; // Simplified: no mock pairings for now
  }

  static Future<void> updatePairingStatus(
    String pairingId,
    String status,
  ) async {
    await Future.delayed(const Duration(milliseconds: 500));
    // No-op for mock
  }

  // ===== APP LIST OPERATIONS (Simplified) =====

  static Future<void> addAppToDevice({
    required String deviceId,
    required String packageName,
    required String appName,
    String? version,
    String? iconUrl,
    String? category,
    bool isSystemApp = false,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));
    // No-op for mock
  }

  static Future<List<Map<String, dynamic>>> getDeviceApps(
    String deviceId,
  ) async {
    await Future.delayed(const Duration(milliseconds: 300));
    return []; // Simplified: no mock apps for now
  }

  static Future<void> updateAppLockStatus({
    required String deviceId,
    required String packageName,
    required bool isLocked,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));
    // No-op for mock
  }

  // ===== LOCK COMMANDS OPERATIONS (Simplified) =====

  static Future<String> sendLockCommand({
    required String parentDeviceId,
    required String childDeviceId,
    required String appPackageName,
    required String commandType,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return 'mock_command_${DateTime.now().millisecondsSinceEpoch}';
  }

  static Future<List<Map<String, dynamic>>> getPendingLockCommands(
    String deviceId,
  ) async {
    await Future.delayed(const Duration(milliseconds: 300));
    return []; // Simplified: no mock commands for now
  }

  static Future<void> updateLockCommandStatus(
    String commandId,
    String status,
  ) async {
    await Future.delayed(const Duration(milliseconds: 500));
    // No-op for mock
  }

  // ===== USAGE STATS OPERATIONS (Simplified) =====

  static Future<void> addUsageStat({
    required String deviceId,
    required String userId,
    required String appPackageName,
    required String appName,
    required DateTime usageDate,
    required int totalTimeMinutes,
    required int openCount,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));
    // No-op for mock
  }

  static Future<List<Map<String, dynamic>>> getUsageStats({
    required String deviceId,
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    await Future.delayed(const Duration(milliseconds: 300));
    return []; // Simplified: no mock usage stats for now
  }

  // ===== REAL-TIME LISTENERS (Simplified) =====

  static Stream<UserModel?> listenToUser(String userId) {
    final user = _firstWhereOrNull<UserModel>(
      mockUsers,
      (u) => u.id == userId,
    );
    return Stream.value(user).asBroadcastStream();
  }

  static Stream<List<DeviceModel>> listenToUserDevices(String userId) {
    final devices =
        mockDevices.where((device) => device.userId == userId).toList();
    return Stream.value(devices).asBroadcastStream();
  }

  static Stream<List<Map<String, dynamic>>> listenToDeviceApps(
    String deviceId,
  ) {
    return Stream.value([]); // Simplified
  }

  static Stream<List<Map<String, dynamic>>> listenToPendingLockCommands(
    String deviceId,
  ) {
    return Stream.value([]); // Simplified
  }
}
