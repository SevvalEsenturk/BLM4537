import 'dart:convert';
import 'package:flutter/foundation.dart'
    show kIsWeb, defaultTargetPlatform, TargetPlatform;
import 'package:http/http.dart' as http;
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'models/register_request.dart';
import 'models/login_request_model.dart';
import 'models/login_response_model.dart';
import 'package:lockapp/src/types/user_model.dart';
import 'package:lockapp/src/constants/app_constants.dart';

part 'auth_repository.g.dart';

class AuthRepository {
  // Backend URL
  String get baseUrl => AppConstants.apiBaseUrl + '/api';

  Future<String> getDeviceId() async {
    if (kIsWeb) return 'web_browser';

    final deviceInfo = DeviceInfoPlugin();
    // Web olmadığı kesin (yukarıdaki if) ama yine de platform kontrolü güvenli
    if (defaultTargetPlatform == TargetPlatform.android) {
      final androidInfo = await deviceInfo.androidInfo;
      return androidInfo.id;
    } else if (defaultTargetPlatform == TargetPlatform.iOS) {
      final iosInfo = await deviceInfo.iosInfo;
      return iosInfo.identifierForVendor ?? 'unknown_ios_id';
    }
    return 'unknown_platform_id';
  }

  Future<void> register(RegisterRequest request) async {
    final url = Uri.parse('$baseUrl/auth/register');
    print('Register Request URL: $url');
    print('Register Request Body: ${jsonEncode(request.toJson())}');

    try {
      // Backend expects Name, but Frontend model lacks it. Use email username as default name.
      final body = request.toJson();
      body['name'] = request.email.split('@')[0];

      print('Sending POST request...');
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(body),
      );
      print('Response Staus: ${response.statusCode}');
      print('Response Body: ${response.body}');

      if (response.statusCode != 200 && response.statusCode != 201) {
        throw Exception('Kayıt başarısız: ${response.body}');
      }
    } catch (e) {
      print('Register Error: $e');
      rethrow;
    }
  }

  Future<UserModel> login(LoginRequestModel request) async {
    final url = Uri.parse('$baseUrl/auth/login');
    print('Login Request URL: $url');

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(request.toJson()),
      );

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        final loginResponse = LoginResponseModel.fromJson(json);

        // Token ve User'ı kaydet
        await _saveAuthData(loginResponse);

        return loginResponse.user;
      } else {
        throw Exception('Giriş başarısız: ${response.body}');
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('auth_token');
    await prefs.remove('auth_user');
  }

  Future<void> _saveAuthData(LoginResponseModel data) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('auth_token', data.token);
    await prefs.setString('auth_user', jsonEncode(data.user.toJson()));
  }

  Future<UserModel?> getCurrentUser() async {
    final prefs = await SharedPreferences.getInstance();
    final userJson = prefs.getString('auth_user');
    if (userJson != null) {
      return UserModel.fromJson(jsonDecode(userJson));
    }
    return null;
  }
}

// Riverpod Provider'ı
@riverpod
AuthRepository authRepository(AuthRepositoryRef ref) {
  return AuthRepository();
}
