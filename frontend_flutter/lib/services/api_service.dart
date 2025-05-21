import 'dart:convert';
import 'package:http/http.dart' as http;

const baseUrl = 'http://10.0.2.2:8000';

class ApiService {
  static Future<String?> login(String user, String pass) async {
    final response = await http.post(
      Uri.parse('$baseUrl/token'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'username': user, 'password': pass}),
    );
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['access'];
    }
    return null;
  }

  static Future<dynamic> getUserData(String token) async {
    final response = await http.get(
      Uri.parse('$baseUrl/usercorp'),
      headers: {'Authorization': 'Bearer $token'},
    );
    return jsonDecode(response.body);
  }

  static Future<dynamic> getTree(String token, int siteId) async {
    final response = await http.get(
      Uri.parse('$baseUrl/tree?site_id=$siteId'),
      headers: {'Authorization': 'Bearer $token'},
    );
    return jsonDecode(response.body);
  }
}
