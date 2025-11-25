import 'package:lockapp/src/api/auth_service.dart';
import 'package:lockapp/src/types/user_model.dart';
import 'package:lockapp/src/types/enums/user_role.dart';
import 'package:lockapp/src/mock/mock_data.dart';

class MockAuthService implements AuthService {
  UserModel? _currentUser;

  @override
  Future<UserModel?> login({
    required String email,
    required String password,
    required UserRole expectedRole,
  }) async {
    await Future.delayed(const Duration(seconds: 1)); // Simulate network delay
    if (email == mockParentUser.email &&
        password == 'password123' &&
        expectedRole == UserRole.parent) {
      _currentUser = mockParentUser;
      return _currentUser;
    } else if (email == mockChildUser.email &&
        password == 'password123' &&
        expectedRole == UserRole.child) {
      _currentUser = mockChildUser;
      return _currentUser;
    }
    return null; // Invalid credentials
  }

  @override
  Future<UserModel?> register({
    required String email,
    required String password,
    required String name,
    required UserRole role,
  }) async {
    await Future.delayed(const Duration(seconds: 1)); // Simulate network delay
    // For simplicity, just return a new user based on input
    final newUser = UserModel(
      id: 'mock_user_${DateTime.now().millisecondsSinceEpoch}',
      email: email,
      name: name,
      role: role,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      isActive: true,
      parentUserId: role == UserRole.child ? mockParentUser.id : null,
    );
    _currentUser = newUser;
    return newUser;
  }

  @override
  Future<void> logout() async {
    await Future.delayed(const Duration(milliseconds: 500)); // Simulate network delay
    _currentUser = null;
  }

  @override
  Future<UserModel?> getCurrentUser() async {
    await Future.delayed(const Duration(milliseconds: 200)); // Simulate network delay
    return _currentUser;
  }

  @override
  Future<UserModel?> updateProfile({
    String? name,
    String? profileImageUrl,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500)); // Simulate network delay
    if (_currentUser != null) {
      _currentUser = _currentUser!.copyWith(
        name: name,
        profileImageUrl: profileImageUrl,
      );
    }
    return _currentUser;
  }

  @override
  Future<bool> resetPassword({required String email}) async {
    await Future.delayed(const Duration(seconds: 1)); // Simulate network delay
    // Always succeed for mock
    return true;
  }
}