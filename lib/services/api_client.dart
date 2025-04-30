import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ApiClient {
  static const String baseUrl = 'http://192.168.6.37:8000/api';
  static const Map<String, String> defaultHeaders = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };

  Future<String?> _getToken() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('access_token');
    print('Retrieved Token: $token');
    return token;
  }

  Future<http.Response> get(String endpoint) async {
    final token = await _getToken();
    if (token == null) {
      throw Exception('No token found. Please login again.');
    }
    final headers = {
      ...defaultHeaders,
      'Authorization': 'Bearer $token',
    };
    print('GET Request: $baseUrl/$endpoint');
    print('Headers: $headers');
    final response = await http.get(
      Uri.parse('$baseUrl/$endpoint'),
      headers: headers,
    );
    print('Response Status: ${response.statusCode}');
    print('Response Body: ${response.body}');
    if (response.statusCode == 401) {
      throw Exception('Unauthorized: Invalid or missing token.');
    } else if (response.statusCode == 429) {
      throw Exception('Terlalu banyak permintaan. Silakan coba lagi nanti.');
    }
    return response;
  }

  Future<http.Response> post(String endpoint, Map<String, dynamic> body) async {
    final token = await _getToken();
    if (token == null && endpoint != 'auth/login' && endpoint != 'auth/register') {
      throw Exception('No token found. Please login again.');
    }
    final headers = {
      ...defaultHeaders,
      if (token != null) 'Authorization': 'Bearer $token',
    };
    print('POST Request: $baseUrl/$endpoint');
    print('Headers: $headers');
    print('Body: $body');
    final response = await http.post(
      Uri.parse('$baseUrl/$endpoint'),
      headers: headers,
      body: jsonEncode(body),
    );
    print('Response Status: ${response.statusCode}');
    print('Response Body: ${response.body}');
    if (response.statusCode == 401) {
      throw Exception('Unauthorized: Invalid or missing token.');
    } else if (response.statusCode == 429) {
      throw Exception('Terlalu banyak permintaan. Silakan coba lagi nanti.');
    }
    return response;
  }
}