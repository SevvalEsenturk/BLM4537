import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:lockapp/src/types/user_model.dart';

part 'user_service.g.dart';

class UserService {
   final String baseUrl = Platform.isAndroid
      ? 'http://10.0.2.2:5216/api'
      : 'http://localhost:5216/api';

   Future<String?> _getToken() async {
     final prefs = await SharedPreferences.getInstance();
     return prefs.getString('auth_token');
   }

   Future<UserModel> updateProfile(int userId, String name, String email) async {
      final token = await _getToken();
      final url = Uri.parse('$baseUrl/users/$userId/profile');

      final response = await http.put(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({'name': name, 'email': email}),
      );

      if (response.statusCode == 200) {
        // Update local user data if needed
        final updatedUser = UserModel.fromJson(jsonDecode(response.body));
        return updatedUser;
      } else {
        throw Exception('Failed to update profile: ${response.body}');
      }
   }

   Future<void> changePassword(int userId, String oldPassword, String newPassword) async {
      final token = await _getToken();
      final url = Uri.parse('$baseUrl/users/$userId/change-password');

      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({'oldPassword': oldPassword, 'newPassword': newPassword}),
      );

      if (response.statusCode != 200) {
         throw Exception('Failed to change password: ${response.body}');
      }
   }
}

@riverpod
UserService userService(UserServiceRef ref) {
  return UserService();
}
