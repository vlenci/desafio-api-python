import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';

const baseUrl = 'http://10.0.2.2:8000';

class ApiService {
  static Future<dynamic> login(String user, String pass) async {
    final response = await http.post(
      Uri.parse('$baseUrl/token'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'username': user, 'password': pass}),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data;
    }
    return null;
  }

  static Future<String?> refreshToken(String refresh) async {
    final response = await http.post(
      Uri.parse('$baseUrl/token/refresh?token=$refresh'),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['access'];
    } else {
      return null;
    }
  }

  static Future<dynamic> getUserData(BuildContext context) async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    final response = await http.get(
      Uri.parse('$baseUrl/usercorp'),
      headers: {'Authorization': 'Bearer ${authProvider.accessToken}'},
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    }

    if (response.statusCode == 403) {
      final newAccessToken = await refreshToken(authProvider.refreshToken);

      if (newAccessToken != null) {
        authProvider.updateAccessToken(newAccessToken);

        final retryResponse = await http.get(
          Uri.parse('$baseUrl/usercorp'),
          headers: {'Authorization': 'Bearer $newAccessToken'},
        );

        if (retryResponse.statusCode == 200) {
          return jsonDecode(retryResponse.body);
        } else {
          throw Exception('Erro ao buscar dados após renovar token');
        }
      } else {
        throw Exception('Não foi possível renovar o token');
      }
    }

    throw Exception('Erro na requisição: ${response.statusCode}');
  }

  static Future<dynamic> getTree(BuildContext context, int siteId) async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    final response = await http.get(
      Uri.parse('$baseUrl/implantation/mobile/tree?site_id=$siteId'),
      headers: {'Authorization': 'Bearer ${authProvider.accessToken}'},
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    }

    if (response.statusCode == 403) {
      final newAccessToken = await refreshToken(authProvider.refreshToken);

      if (newAccessToken != null) {
        authProvider.updateAccessToken(newAccessToken);

        final retryResponse = await http.get(
          Uri.parse('$baseUrl/implantation/mobile/tree?site_id=$siteId'),
          headers: {'Authorization': 'Bearer $newAccessToken'},
        );

        if (retryResponse.statusCode == 200) {
          return jsonDecode(retryResponse.body);
        } else {
          throw Exception('Erro ao buscar dados após renovar token');
        }
      } else {
        throw Exception('Não foi possível renovar o token');
      }
    }

    throw Exception('Erro na requisição: ${response.statusCode}');
  }
}
