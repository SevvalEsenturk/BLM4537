import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:lockapp/src/api/auth_service.dart';
import 'package:lockapp/src/api/real_auth_service.dart';
import 'package:lockapp/src/api/user_api_service.dart';
import 'package:lockapp/src/constants/app_constants.dart';

part 'auth_service_provider.g.dart';

@riverpod
UserApiService userApiService(UserApiServiceRef ref) {
  return UserApiService(baseUrl: AppConstants.apiBaseUrl);
}

@riverpod
AuthService authService(AuthServiceRef ref) {
  final apiService = ref.watch(userApiServiceProvider);
  return RealAuthService(userApiService: apiService);
} 