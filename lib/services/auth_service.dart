import 'dart:convert';
import 'package:http/http.dart' as http;
import '../config/api_config.dart';
import '../models/user_model.dart';

class AuthService {
  Future<UserModel?> login(String email, String password) async {
    final url = Uri.parse("${ApiConfig.BaseUrl}/login.php");

    final response = await http.post(url, body: {
      'email': email,
      'password': password,
    });

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data['status'] == 'success') {
        return UserModel.fromJson(data['user']);
      } else {
        throw Exception(data['message']);
      }
    } else {
      throw Exception("Gagal menghubungkan ke server");
    }
  }
}
