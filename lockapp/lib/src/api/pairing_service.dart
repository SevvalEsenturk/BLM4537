import 'package:dio/dio.dart';
import '../types/pairing_models.dart';
import '../constants/app_constants.dart';

class PairingService {
  final Dio _dio;

  PairingService({Dio? dio})
      : _dio = dio ??
            Dio(BaseOptions(
              baseUrl: AppConstants.apiBaseUrl,
              connectTimeout: const Duration(seconds: 10),
              receiveTimeout: const Duration(seconds: 10),
            ));

  Future<PairingCode> createCode(int parentId) async {
    try {
      final response = await _dio.post(
        '/api/pairing/create-code',
        queryParameters: {'parentId': parentId},
      );
      return PairingCode.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }

  Future<Map<String, dynamic>> submitPairingRequest({
    required int parentUserId,
    required int childUserId,
    required String code,
    required String deviceName,
    required String deviceType,
  }) async {
    try {
      final response = await _dio.post(
        '/api/pairing/request',
        data: {
          'parentUserId': parentUserId,
          'childUserId': childUserId,
          'code': code,
          'deviceName': deviceName,
          'deviceType': deviceType,
        },
      );
      return response.data;
    } catch (e) {
      rethrow;
    }
  }

  Future<List<PairingRequest>> getPendingRequests(int parentId) async {
    try {
      final response = await _dio.get(
        '/api/pairing/pending',
        queryParameters: {'parentId': parentId},
      );
      final list = (response.data as List)
          .map((e) => PairingRequest.fromJson(e as Map<String, dynamic>))
          .toList();
      return list;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> approvePairingRequest(int requestId) async {
    try {
      await _dio.post('/api/pairing/$requestId/approve');
    } catch (e) {
      rethrow;
    }
  }

  Future<void> rejectPairingRequest(int requestId) async {
    try {
      await _dio.post('/api/pairing/$requestId/reject');
    } catch (e) {
      rethrow;
    }
  }
}
