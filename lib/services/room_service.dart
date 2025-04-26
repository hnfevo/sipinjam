import 'dart:convert';
import 'package:http/http.dart' as http;
import 'api_client.dart';
import '../features/room/models/room.dart';

class RoomService {
  final ApiClient _apiClient = ApiClient();

  Future<List<Room>> getRooms() async {
    final response = await _apiClient.get('mobile/rooms?available=true');
    final body = jsonDecode(response.body);

    if (response.statusCode == 200 && body['status'] == true) {
      final rooms = (body['data'] as List).map((json) => Room.fromJson(json)).toList();
      return rooms;
    } else {
      throw Exception(body['message'] ?? 'Gagal mengambil data ruangan');
    }
  }

  Future<Map<String, dynamic>> createBooking({
    required int roomId,
    required String purpose,
    required DateTime startTime,
    required DateTime endTime,
  }) async {
    final response = await _apiClient.post('mobile/bookings', {
      'room_id': roomId,
      'purpose': purpose,
      'start_time': startTime.toIso8601String(),
      'end_time': endTime.toIso8601String(),
    });

    final body = jsonDecode(response.body);
    if (response.statusCode == 201) {
      return body;
    } else {
      throw Exception(body['message'] ?? 'Gagal membuat booking');
    }
  }
}