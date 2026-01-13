import 'package:permission_handler/permission_handler.dart' as permission_handler;

class PermissionService {
  PermissionService._();

  static const List<permission_handler.Permission> _criticalPermissions = [
    permission_handler.Permission.systemAlertWindow,
  ];

  /// Check if all critical permissions are granted
  static Future<bool> areAllPermissionsGranted() async {
    print('Mock PermissionService: areAllPermissionsGranted called, returning true');
    await Future.delayed(const Duration(milliseconds: 50));
    return true; // Always granted in mock
  }

  /// Request all critical permissions
  static Future<Map<permission_handler.Permission, permission_handler.PermissionStatus>> requestAllPermissions() async {
    print('Mock PermissionService: requestAllPermissions called, returning granted status');
    await Future.delayed(const Duration(milliseconds: 50));
    return {
      permission_handler.Permission.systemAlertWindow: permission_handler.PermissionStatus.granted,
    };
  }

  /// Check specific permission status
  static Future<permission_handler.PermissionStatus> checkPermission(permission_handler.Permission permission) async {
    print('Mock PermissionService: checkPermission called for ${permission.toString()}, returning granted');
    await Future.delayed(const Duration(milliseconds: 50));
    return permission_handler.PermissionStatus.granted; // Always granted in mock
  }

  /// Request specific permission
  static Future<permission_handler.PermissionStatus> requestPermission(permission_handler.Permission permission) async {
    print('Mock PermissionService: requestPermission called for ${permission.toString()}, returning granted');
    await Future.delayed(const Duration(milliseconds: 50));
    return permission_handler.PermissionStatus.granted; // Always granted in mock
  }

  /// Get permission name for UI
  static String getPermissionName(permission_handler.Permission permission) {
    return 'Mock Permission Name';
  }

  /// Get permission description for UI
  static String getPermissionDescription(permission_handler.Permission permission) {
    return 'Mock Permission Description';
  }

  /// Get permission icon for UI
  static String getPermissionIcon(permission_handler.Permission permission) {
    return '✅';
  }

  /// Check if permission is permanently denied
  static Future<bool> isPermanentlyDenied(permission_handler.Permission permission) async {
    print('Mock PermissionService: isPermanentlyDenied called, returning false');
    await Future.delayed(const Duration(milliseconds: 50));
    return false; // Never permanently denied in mock
  }

  /// Open app settings - Native Android method
  static Future<bool> openAppSettings() async {
    print('Mock PermissionService: openAppSettings called');
    await Future.delayed(const Duration(milliseconds: 50));
    return true;
  }

  /// Open Usage Access Settings - Native Android method
  static Future<void> openUsageAccessSettings() async {
    print('Mock PermissionService: openUsageAccessSettings called');
    await Future.delayed(const Duration(milliseconds: 50));
  }

  /// Open Accessibility Settings - Native Android method
  static Future<void> openAccessibilitySettings() async {
    print('Mock PermissionService: openAccessibilitySettings called');
    await Future.delayed(const Duration(milliseconds: 50));
  }

  /// Open Device Admin Settings - Native Android method
  static Future<void> openDeviceAdminSettings() async {
    print('Mock PermissionService: openDeviceAdminSettings called');
    await Future.delayed(const Duration(milliseconds: 50));
  }

  /// Open System Alert Window Settings (Overlay permissions) - Native Android method
  static Future<void> openSystemAlertWindowSettings() async {
    print('Mock PermissionService: openSystemAlertWindowSettings called');
    await Future.delayed(const Duration(milliseconds: 50));
  }

  /// Native Android izin kontrol metodları
  static Future<bool> checkUsageAccessPermission() async {
    print('Mock PermissionService: checkUsageAccessPermission called, returning true');
    await Future.delayed(const Duration(milliseconds: 50));
    return true;
  }

  static Future<bool> checkAccessibilityPermission() async {
    print('Mock PermissionService: checkAccessibilityPermission called, returning true');
    await Future.delayed(const Duration(milliseconds: 50));
    return true;
  }

  static Future<bool> checkDeviceAdminPermission() async {
    print('Mock PermissionService: checkDeviceAdminPermission called, returning true');
    await Future.delayed(const Duration(milliseconds: 50));
    return true;
  }

  static Future<bool> checkOverlayPermission() async {
    print('Mock PermissionService: checkOverlayPermission called, returning true');
    await Future.delayed(const Duration(milliseconds: 50));
    return true;
  }

  /// Otomatik izin isteme metodları
  static Future<void> requestAccessibilityPermission() async {
    print('Mock PermissionService: requestAccessibilityPermission called');
    await Future.delayed(const Duration(milliseconds: 50));
  }

  static Future<void> requestDeviceAdminPermission() async {
    print('Mock PermissionService: requestDeviceAdminPermission called');
    await Future.delayed(const Duration(milliseconds: 50));
  }

  /// Get all critical permissions list
  static List<permission_handler.Permission> get criticalPermissions => _criticalPermissions;
}