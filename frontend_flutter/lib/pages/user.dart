import 'package:flutter/material.dart';
import 'package:frontend_flutter/models/json_viewer.dart';
import 'package:frontend_flutter/services/api_service.dart';

class UserPage extends StatelessWidget {
  const UserPage({super.key});

  Future<dynamic> _fetchUserData(BuildContext context) async {
    return await ApiService.getUserData(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Dados do Usuário',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w200),
        ),
        backgroundColor: Color(0xFF0C113D),
        iconTheme: const IconThemeData(color: Colors.white),
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: _fetchUserData(context),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Erro: ${snapshot.error}'));
          } else {
            return Padding(
              padding: const EdgeInsets.all(16),
              child: JsonViewer(snapshot.data),
            );
          }
        },
      ),
    );
  }
}
