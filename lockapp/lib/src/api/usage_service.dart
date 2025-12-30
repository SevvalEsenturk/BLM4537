import 'package:dio/dio.dart';
import '../types/usage_models.dart';
import '../constants/app_constants.dart';

class UsageService {
  final Dio _dio;

  UsageService({Dio? dio})
      : _dio = dio ??
            Dio(BaseOptions(
              baseUrl: AppConstants.apiBaseUrl,
              connectTimeout: const Duration(seconds: 10),
              receiveTimeout: const Duration(seconds: 10),
            ));

  Future<void> createUsageRecord({
    required int childUserId,
    required String appName,
    required int usageMinutes,
    String? appCategory,
    DateTime? recordDate,
  }) async {
    try {
      await _dio.post(
        '/api/usage',
        data: {
          'childUserId': childUserId,
          'appName': appName,
          'usageMinutes': usageMinutes,
          'appCategory': appCategory,
          'recordDate': recordDate?.toIso8601String(),
        },
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<UsageSummary> getUsageSummary({
    required int childId,
    required String range,
  }) async {
    try {
      final response = await _dio.get(
        '/api/usage/summary',
        queryParameters: {'childId': childId, 'range': range},
      );
      return UsageSummary.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }

  Future<List<TopApp>> getTopApps({
    required int childId,
    required String range,
  }) async {
    try {
      final response = await _dio.get(
        '/api/usage/topapps',
        queryParameters: {'childId': childId, 'range': range},
      );
      final list = (response.data as List)
          .map((e) => TopApp.fromJson(e as Map<String, dynamic>))
          .toList();
      return list;
    } catch (e) {
      rethrow;
    }
  }
}
