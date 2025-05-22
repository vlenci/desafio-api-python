import 'package:flutter/material.dart';
import 'package:frontend_flutter/models/json_viewer.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import '../services/api_service.dart';

class UserPage extends StatelessWidget {
  const UserPage({super.key});

  @override
  Widget build(BuildContext context) {
    final token = Provider.of<AuthProvider>(context, listen: false).token;

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
        future: ApiService.getUserData(token),
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
