import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'package:lockapp/src/constants/app_constants.dart';
import 'package:lockapp/src/types/pairing_request.dart';
import 'package:lockapp/src/types/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class QrPairingService {
  String get baseUrl => AppConstants.apiBaseUrl + '/api';

  Future<String?> _getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('auth_token');
  }

  Future<UserModel?> _getCurrentUser() async {
    final prefs = await SharedPreferences.getInstance();
    final userJson = prefs.getString('auth_user');
    if (userJson != null) {
      return UserModel.fromJson(jsonDecode(userJson));
    }
    return null;
  }

  /// Generate QR code for parent device
  /// Returns a PairingRequest object where the 'qrCode' field contains "ParentID:Code"
  Future<PairingRequest> generatePairingRequest({
    required String parentName,
    required String parentDeviceId,
  }) async {
    final user = await _getCurrentUser();
    if (user == null) throw Exception('Kullanıcı oturumu bulunamadı');

    // 1. Get a random code from Backend (optional, or just generate locally)
    // Using local generation for simplicity as backend create-code is stateless
    final code = _generateRandomCode(6);
    
    // 2. Format the QR string to include ParentID so child knows who to pair with
    // Format: "PARENT_ID:CODE"
    final qrString = "${user.id}:$code";

    // Return a dummy request object to display the QR
    // In a real app, we might want to save this "intent" to DB, but backend logic 
    // relies on Child initiating the request.
    return PairingRequest(
      id: 'local_${DateTime.now().millisecondsSinceEpoch}',
      parentUserId: user.id,
      parentDeviceId: parentDeviceId,
      parentName: user.name,
      qrCode: qrString, // THIS IS WHAT THE CHILD SCANS
      createdAt: DateTime.now(),
      expiresAt: DateTime.now().add(const Duration(minutes: 10)),
    );
  }

  /// Scan QR code and submit pairing request to backend
  Future<UserModel?> acceptPairingRequest(String qrCode, String childName) async {
    final user = await _getCurrentUser();
    if (user == null) throw Exception('Çocuk kullanıcı oturumu bulunamadı');

    // 1. Parse QR Code (Format: "ParentID:Code")
    final parts = qrCode.split(':');
    if (parts.length != 2) {
      throw Exception('Geçersiz QR Kod formatı');
    }
    final parentIdStr = parts[0];
    final code = parts[1];

    int parentId;
    try {
      parentId = int.parse(parentIdStr);
    } catch (e) {
      throw Exception('Geçersiz Ebeveyn ID');
    }

    // 2. Submit Request to Backend
    final url = Uri.parse('$baseUrl/pairing/request');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'parentUserId': parentId,
        'childUserId': int.parse(user.id),
        'code': code,
        'deviceName': "$childName's Device", // Simple device name
        'deviceType': 'mobile'
      }),
    );

    if (response.statusCode != 200 && response.statusCode != 201) {
      throw Exception('Eşleştirme isteği başarısız: ${response.body}');
    }

    // 3. Return the current user to indicate success
    return user;
  }

  /// Get active pairing requests (PENDING requests for Parent)
  Future<List<PairingRequest>> getActivePairingRequests() async {
     final user = await _getCurrentUser();
    if (user == null) return [];

    final url = Uri.parse('$baseUrl/pairing/pending?parentId=${user.id}');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => PairingRequest(
        id: json['id'].toString(),
        parentUserId: user.id,
        parentName: user.name,
        parentDeviceId: 'unknown',
        qrCode: '***', // Code is hidden/not needed here
        createdAt: DateTime.parse(json['createdAt']),
        expiresAt: DateTime.parse(json['expiresAt']),
        childUserId: json['childId'].toString(),
        childName: json['childName'],
        // status: 'Pending' // Removed as it is not in the model
      )).toList().cast<PairingRequest>(); // Explicit cast to help type inference if needed, though map().toList() should work if generics are correct.
      // Better yet, let's fix the map return type inference
      
      return data.map<PairingRequest>((json) => PairingRequest(
        id: json['id'].toString(),
        parentUserId: user.id,
        parentName: user.name,
        parentDeviceId: 'unknown',
        qrCode: '***',
        createdAt: DateTime.parse(json['createdAt']),
        expiresAt: DateTime.parse(json['expiresAt']),
        childUserId: json['childId'].toString(),
        childName: json['childName'],
        isUsed: false, // Defaulting to false as 'Pending' implies not fully used/completed or logic mapping needed
      )).toList();
    }
    return [];
  }

  Future<void> approvePairingRequest(String requestId) async {
    final url = Uri.parse('$baseUrl/pairing/$requestId/approve');
    final response = await http.post(url);
    if (response.statusCode != 200) {
      throw Exception('Onaylama başarısız');
    }
  }

  Future<void> rejectPairingRequest(String requestId) async {
    final url = Uri.parse('$baseUrl/pairing/$requestId/reject');
    final response = await http.post(url);
    if (response.statusCode != 200) {
      throw Exception('Reddetme başarısız');
    }
  }

  Future<void> deletePairingRequest(String requestId) async {
    // Local cleanup or backend cancel if supported
  }

  String _generateRandomCode(int length) {
    const chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    final random = Random();
    return List.generate(length, (index) => chars[random.nextInt(chars.length)]).join();
  }
}
