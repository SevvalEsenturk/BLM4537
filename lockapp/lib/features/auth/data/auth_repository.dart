import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:device_info_plus/device_info_plus.dart'; 
import 'models/register_request.dart';

part 'auth_repository.g.dart';

class AuthRepository {
  //Backend Sunucu Adresim burada 
  // 10.0.2.2 Android emülatör için -->  bilgisayarın localhostu
  final String baseUrl = Platform.isAndroid 
      ? 'http://10.0.2.2:5000/api' 
      : 'http://localhost:5000/api';

  // Platforma özel benzersiz cihaz ID'sinı yapıştırdık
  Future<String> getDeviceId() async {
    final deviceInfo = DeviceInfoPlugin();
    if (Platform.isAndroid) {
      final androidInfo = await deviceInfo.androidInfo;
      // Android ID
      return androidInfo.id;
    } else if (Platform.isIOS) {
      final iosInfo = await deviceInfo.iosInfo;
      // IDFV (Identifier for Vendor) iOS için kullandık
      return iosInfo.identifierForVendor ?? 'unknown_ios_id';
    }
    return 'unknown_platform_id';
  }

  Future<void> register(RegisterRequest request) async {
    final url = Uri.parse('$baseUrl/auth/register');
    
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(request.toJson()),
      );

      if (response.statusCode != 200 && response.statusCode != 201) {
        throw Exception('Kayıt başarısız: ${response.body}');
      }
      
    } catch (e) {
      rethrow;
    }
  }
}

// Riverpod Provider'ı
@riverpod
AuthRepository authRepository(AuthRepositoryRef ref) {
  return AuthRepository();
}

