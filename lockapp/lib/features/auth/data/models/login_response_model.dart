import 'package:lockapp/src/types/user_model.dart';
import 'package:lockapp/src/types/enums/user_role.dart';

class LoginResponseModel {
  final String token;
  final UserModel user;

  LoginResponseModel({required this.token, required this.user});

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) {
    // Backend returns flat structure: { token, id, name, email, role }
    // We need to construct UserModel from it.
    
    // Check if user object is nested or flat
    final userData = json['user'] as Map<String, dynamic>?;
    
    if (userData != null) {
       return LoginResponseModel(
        token: json['token'] as String,
        user: UserModel.fromJson(userData),
      );
    }

    // Handle flat structure from our LoginResponseDto
    return LoginResponseModel(
      token: json['token'] as String,
      user: UserModel(
        id: json['id'].toString(),
        name: json['name'] as String,
        email: json['email'] as String,
        role: UserRole.fromString(json['role'] as String),
        createdAt: DateTime.now(), // Backend doesn't send this yet in LoginResponseDto
        updatedAt: DateTime.now(),
      ),
    );
  }
}
