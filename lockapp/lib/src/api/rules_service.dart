import 'package:dio/dio.dart';
import '../types/rule_models.dart';
import '../constants/app_constants.dart';

class RulesService {
  final Dio _dio;

  RulesService({Dio? dio})
      : _dio = dio ??
            Dio(BaseOptions(
              baseUrl: AppConstants.apiBaseUrl,
              connectTimeout: const Duration(seconds: 10),
              receiveTimeout: const Duration(seconds: 10),
            ));

  Future<TimeRule?> getRule(int childId) async {
    try {
      final response = await _dio.get('/api/rules/$childId');
      if (response.statusCode == 404) return null;
      return TimeRule.fromJson(response.data);
    } on DioException catch (e) {
      if (e.response?.statusCode == 404) return null;
      rethrow;
    }
  }

  Future<Map<String, dynamic>> upsertRule({
    required int childId,
    required int dailyLimitMinutes,
    Duration? allowedWindowStart,
    Duration? allowedWindowEnd,
    String? activeDaysJson,
    String? exceptionsJson,
  }) async {
    try {
      final response = await _dio.put(
        '/api/rules/$childId',
        data: {
          'dailyLimitMinutes': dailyLimitMinutes,
          'allowedWindowStart': allowedWindowStart,
          'allowedWindowEnd': allowedWindowEnd,
          'activeDaysJson': activeDaysJson,
          'exceptionsJson': exceptionsJson,
        },
      );
      return response.data;
    } catch (e) {
      rethrow;
    }
  }
}
