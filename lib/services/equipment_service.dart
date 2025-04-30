import 'dart:convert';
import 'api_client.dart';
import '../features/equipment/models/equipment.dart';

class EquipmentService {
  final ApiClient _apiClient = ApiClient();

  Future<List<Equipment>> getEquipments() async {
    final response = await _apiClient.get('mobile/equipments?available=true');
    final body = jsonDecode(response.body);

    if (response.statusCode == 200 && body['status'] == true) {
      final equipments = (body['data'] as List).map((json) => Equipment.fromJson(json)).toList();
      return equipments;
    } else {
      throw Exception(body['message'] ?? 'Gagal mengambil data alat');
    }
  }

  Future<Map<String, dynamic>> createLoan({
    required int equipmentId,
    required int quantity,
    required String purpose,
    required DateTime loanDate,
    required DateTime returnDate,
  }) async {
    final response = await _apiClient.post('mobile/equipment-loans', {
      'equipment_id': equipmentId,
      'quantity': quantity,
      'purpose': purpose,
      'loan_date': loanDate.toIso8601String(),
      'return_date': returnDate.toIso8601String(),
    });

    final body = jsonDecode(response.body);
    if (response.statusCode == 201) {
      return body;
    } else {
      throw Exception(body['message'] ?? 'Gagal membuat peminjaman alat');
    }
  }

  Future<Map<String, dynamic>> returnLoan(int loanId) async {
    final response = await _apiClient.post('mobile/equipment-loans/$loanId/return', {});
    final body = jsonDecode(response.body);

    if (response.statusCode == 200) {
      return body;
    } else {
      throw Exception(body['message'] ?? 'Gagal mengembalikan alat');
    }
  }
}