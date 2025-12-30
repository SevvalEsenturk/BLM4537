import 'package:dio/dio.dart';
import '../types/notification_models.dart';
import '../constants/app_constants.dart';

class NotificationService {
  final Dio _dio;

  NotificationService({Dio? dio})
      : _dio = dio ??
            Dio(BaseOptions(
              baseUrl: AppConstants.apiBaseUrl,
              connectTimeout: const Duration(seconds: 10),
              receiveTimeout: const Duration(seconds: 10),
            ));

  Future<List<NotificationItem>> getNotifications(int userId) async {
    try {
      final response = await _dio.get(
        '/api/notifications',
        queryParameters: {'userId': userId},
      );
      final list = (response.data as List)
          .map((e) => NotificationItem.fromJson(e as Map<String, dynamic>))
          .toList();
      return list;
    } catch (e) {
      rethrow;
    }
  }
}
