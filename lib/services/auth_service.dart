import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'api_client.dart';

class AuthService {
  final ApiClient _apiClient = ApiClient();

  // Register
  Future<Map<String, dynamic>> register({
    required String name,
    required String email,
    required String password,
    required String passwordConfirmation,
    required String nimNidn,
    required String role,
    required String phone,
  }) async {
    final response = await _apiClient.post('auth/register', {
      'name': name,
      'email': email,
      'password': password,
      'password_confirmation': passwordConfirmation,
      'nim_nidn': nimNidn,
      'role': role,
      'phone': phone,
    });

    final body = jsonDecode(response.body);
    if (response.statusCode == 201) {
      return body;
    } else {
      throw Exception(body['message'] ?? 'Register gagal');
    }
  }

  // Login
  Future<Map<String, dynamic>> login({
    required String email,
    required String password,
  }) async {
    final response = await _apiClient.post('auth/login', {
      'email': email,
      'password': password,
    });

    final body = jsonDecode(response.body);
    if (response.statusCode == 200) {
      // Simpan token ke SharedPreferences
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('access_token', body['access_token']);
      await prefs.setString('user', jsonEncode(body['user']));
      return body;
    } else {
      throw Exception(body['message'] ?? 'Login gagal');
    }
  }

  // Logout
  Future<Map<String, dynamic>> logout() async {
    final response = await _apiClient.post('auth/logout', {});
    final body = jsonDecode(response.body);

    if (response.statusCode == 200) {
      // Hapus token dari SharedPreferences
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove('access_token');
      await prefs.remove('user');
      return body;
    } else {
      throw Exception(body['message'] ?? 'Logout gagal');
    }
  }

  // Mendapatkan data user dari SharedPreferences
  Future<Map<String, dynamic>?> getUser() async {
    final prefs = await SharedPreferences.getInstance();
    final userString = prefs.getString('user');
    if (userString != null) {
      return jsonDecode(userString);
    }
    return null;
  }

  // Cek apakah user sudah login
  Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('access_token') != null;
  }
}