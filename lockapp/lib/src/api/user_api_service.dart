import 'dart:convert';
import 'package:http/http.dart' as http;

class UserApiService {
  final String baseUrl;

  UserApiService({required this.baseUrl});

  /// Tüm kullanıcıları getir
  Future<List<Map<String, dynamic>>> getUsers() async {
    final url = Uri.parse('$baseUrl/api/users');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.cast<Map<String, dynamic>>();
    } else {
      throw Exception('Failed to load users: ${response.statusCode}');
    }
  }

  /// Yeni user oluştur (şimdilik aynı Swagger’daki gibi)
  Future<Map<String, dynamic>> createUser({
    required String name,
    required String email,
    required String password,
    String role = 'Parent',
  }) async {
    final url = Uri.parse('$baseUrl/api/users');

    final body = jsonEncode({
      'name': name,
      'email': email,
      'passwordHash': password, // backend'de PasswordHash
      'role': role,
    });

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: body,
    );

    if (response.statusCode == 201) {
      return jsonDecode(response.body) as Map<String, dynamic>;
    } else {
      throw Exception(
        'Failed to create user: ${response.statusCode} ${response.body}',
      );
    }
  }
}
