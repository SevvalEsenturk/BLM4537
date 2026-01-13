import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../data/auth_repository.dart';
import '../data/models/register_request.dart';

part 'auth_controller.g.dart';

@riverpod
class AuthController extends _$AuthController {
  @override
  FutureOr<void> build() {
    // Başlangıç durumu
  }

  Future<void> register({
    required String email,
    required String password,
    required String role,
  }) async {
    state = const AsyncLoading();

    try {
      // 1. Cihaz ID'sini al
      final deviceId = await ref.read(authRepositoryProvider).getDeviceId();

      // 2. Kayıt isteğini hazırla
      final request = RegisterRequest(
        email: email,
        password: password,
        role: role,
        deviceId: deviceId,
      );

      // 3. API'ye gönder
      await ref.read(authRepositoryProvider).register(request);

      state = const AsyncData(null);
    } catch (e, st) {
      state = AsyncError(e, st);
      rethrow;
    }
  }
}
