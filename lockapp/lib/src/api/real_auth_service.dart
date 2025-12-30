import 'package:lockapp/src/api/auth_service.dart';
import 'package:lockapp/src/api/user_api_service.dart';
import 'package:lockapp/src/types/user_model.dart';
import 'package:lockapp/src/types/enums/user_role.dart';

class RealAuthService implements AuthService {
  final UserApiService userApiService;

  RealAuthService({required this.userApiService});

  @override
  Future<UserModel?> login({
    required String email,
    required String password,
    required UserRole expectedRole,
  }) async {
    try {
      // NOTE: Backend'de henüz login endpoint'i yok
      // Geçici olarak tüm users'ları getir ve email ile eşleş
      final users = await userApiService.getUsers();
      
      for (final userMap in users) {
        if (userMap['email'] == email) {
          // JSON map'ı UserModel'e dönüştür
          return UserModel.fromJson(userMap);
        }
      }
      
      throw Exception('User not found');
    } catch (e) {
      print('Login error: $e');
      return null;
    }
  }

  @override
  Future<UserModel?> register({
    required String email,
    required String password,
    required String name,
    required UserRole role,
  }) async {
    try {
      final userMap = await userApiService.createUser(
        name: name,
        email: email,
        password: password,
        role: role.toString().split('.').last.toUpperCase(),
      );
      
      return UserModel.fromJson(userMap);
    } catch (e) {
      print('Registration error: $e');
      return null;
    }
  }

  @override
  Future<void> logout() async {
    // Implement logout logic if needed
    print('User logged out');
  }

  @override
  Future<UserModel?> getCurrentUser() async {
    // Implement if backend supports it
    return null;
  }

  @override
  Future<UserModel?> updateProfile({
    String? name,
    String? profileImageUrl,
  }) async {
    // Implement if backend supports it
    return null;
  }

  @override
  Future<bool> resetPassword({required String email}) async {
    // Implement if backend supports it
    return false;
  }
}
