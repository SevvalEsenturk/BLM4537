import 'package:lockapp/src/types/user_model.dart';
import 'package:lockapp/src/types/device_model.dart';
import 'package:lockapp/src/types/enums/user_role.dart';

// Mock User Data
final mockParentUser = UserModel(
  id: 'parent_123',
  email: 'parent@example.com',
  name: 'Parent User',
  role: UserRole.parent,
  createdAt: DateTime.now().subtract(const Duration(days: 30)),
  updatedAt: DateTime.now().subtract(const Duration(days: 1)),
  isActive: true,
);

final mockChildUser = UserModel(
  id: 'child_456',
  email: 'child@example.com',
  name: 'Child User',
  role: UserRole.child,
  parentUserId: 'parent_123',
  createdAt: DateTime.now().subtract(const Duration(days: 20)),
  updatedAt: DateTime.now().subtract(const Duration(hours: 5)),
  isActive: true,
);

// Mock Device Data
final mockParentDevice = DeviceModel(
  id: 'device_parent_001',
  userId: 'parent_123',
  deviceName: 'Parent Phone',
  deviceId: 'parent_phone_uuid',
  deviceType: DeviceType.parentDevice,
  status: DeviceStatus.active,
  osVersion: 'iOS 17.0',
  appVersion: '1.0.0',
  deviceModel: 'iPhone 15 Pro',
  isOnline: true,
  lastSeen: DateTime.now().subtract(const Duration(minutes: 5)),
  createdAt: DateTime.now().subtract(const Duration(days: 25)),
  updatedAt: DateTime.now().subtract(const Duration(minutes: 10)),
);

final mockChildDevice = DeviceModel(
  id: 'device_child_001',
  userId: 'child_456',
  deviceName: 'Child Tablet',
  deviceId: 'child_tablet_uuid',
  deviceType: DeviceType.childDevice,
  status: DeviceStatus.active,
  osVersion: 'Android 13',
  appVersion: '1.0.0',
  deviceModel: 'Samsung Galaxy Tab',
  isOnline: true,
  lastSeen: DateTime.now().subtract(const Duration(minutes: 2)),
  createdAt: DateTime.now().subtract(const Duration(days: 15)),
  updatedAt: DateTime.now().subtract(const Duration(minutes: 3)),
);

final mockChildDeviceBlocked = DeviceModel(
  id: 'device_child_002',
  userId: 'child_456',
  deviceName: 'Child Phone (Blocked)',
  deviceId: 'child_phone_blocked_uuid',
  deviceType: DeviceType.childDevice,
  status: DeviceStatus.blocked,
  osVersion: 'Android 12',
  appVersion: '1.0.0',
  deviceModel: 'Xiaomi Redmi',
  isOnline: false,
  lastSeen: DateTime.now().subtract(const Duration(hours: 1)),
  createdAt: DateTime.now().subtract(const Duration(days: 10)),
  updatedAt: DateTime.now().subtract(const Duration(hours: 1)),
);

final List<UserModel> mockUsers = [mockParentUser, mockChildUser];
final List<DeviceModel> mockDevices = [mockParentDevice, mockChildDevice, mockChildDeviceBlocked];