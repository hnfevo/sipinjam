import 'dart:convert';
import 'package:http/http.dart' as http;
import 'api_client.dart';
import '../features/history/models/booking.dart';

class HistoryService {
  final ApiClient _apiClient = ApiClient();

  Future<List<Booking>> getBookings() async {
    final response = await _apiClient.get('mobile/bookings');
    final body = jsonDecode(response.body);

    if (response.statusCode == 200 && body['status'] == true) {
      return (body['data'] as List).map((json) => Booking.fromJson(json)).toList();
    } else {
      throw Exception(body['message'] ?? 'Gagal mengambil riwayat booking');
    }
  }

  Future<List<Booking>> getEquipmentLoans() async {
    final response = await _apiClient.get('mobile/equipment-loans');
    final body = jsonDecode(response.body);

    if (response.statusCode == 200 && body['status'] == true) {
      return (body['data'] as List).map((json) => Booking.fromJson(json)).toList();
    } else {
      throw Exception(body['message'] ?? 'Gagal mengambil riwayat peminjaman alat');
    }
  }

  Future<Map<String, dynamic>> cancelLoan(int loanId) async {
    final response = await _apiClient.post('mobile/equipment-loans/$loanId/cancel', {});
    final body = jsonDecode(response.body);

    if (response.statusCode == 200) {
      return body;
    } else {
      throw Exception(body['message'] ?? 'Gagal membatalkan peminjaman');
    }
  }
}