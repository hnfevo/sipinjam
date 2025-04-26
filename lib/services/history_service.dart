import 'dart:convert';
import 'package:http/http.dart' as http;
import 'api_client.dart';
import '../features/history/models/booking.dart';
import 'equipment_service.dart';

class HistoryService {
  final ApiClient _apiClient = ApiClient();
  final EquipmentService _equipmentService = EquipmentService();

  Future<List<Booking>> getBookings() async {
    final response = await _apiClient.get('mobile/bookings');
    final body = jsonDecode(response.body);

    if (response.statusCode == 200 && body['status'] == true) {
      final bookings = (body['data'] as List).map((json) => Booking.fromRoomJson(json)).toList();
      return bookings;
    } else {
      throw Exception(body['message'] ?? 'Gagal mengambil riwayat peminjaman ruangan');
    }
  }

  Future<List<Booking>> getEquipmentLoans() async {
    final response = await _apiClient.get('mobile/equipment-loans');
    final body = jsonDecode(response.body);

    if (response.statusCode == 200 && body['status'] == true) {
      final loans = (body['data'] as List).map((json) => Booking.fromEquipmentJson(json)).toList();
      return loans;
    } else {
      throw Exception(body['message'] ?? 'Gagal mengambil riwayat peminjaman alat');
    }
  }

  Future<Map<String, dynamic>> cancelLoan(int loanId) async {
    return await _equipmentService.returnLoan(loanId);
  }
}