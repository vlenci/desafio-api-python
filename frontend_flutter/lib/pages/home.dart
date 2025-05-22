import 'package:flutter/material.dart';
import 'package:frontend_flutter/pages/login.dart';
import 'user.dart';
import 'tree.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF0C113D),
        title: Image.asset('assets/logo-semeq-branco.png', height: 30),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(40),
          child: Container(
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(horizontal: 16),
            color: Color.fromARGB(255, 7, 10, 36),
            width: double.infinity,
            height: 40,
            child: Text(
              "Home",
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w300,
              ),
            ),
          ),
        ),

        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            color: Colors.white,
            onPressed: () {
              auth.logout();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => const LoginPage()),
              );
            },
          ),
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll<Color>(
                    Color(0xFFe46c1c),
                  ),
                  minimumSize: WidgetStatePropertyAll(Size(200, 60)),
                  padding: WidgetStatePropertyAll(
                    EdgeInsets.symmetric(horizontal: 36, vertical: 24),
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const UserPage()),
                  );
                },
                child: const Text(
                  'Ver Dados do Usuário',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 40),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll<Color>(
                    Color(0xFFe46c1c),
                  ),
                  minimumSize: WidgetStatePropertyAll(Size(200, 60)),
                  padding: WidgetStatePropertyAll(
                    EdgeInsets.symmetric(horizontal: 54, vertical: 24),
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const TreePage()),
                  );
                },
                child: const Text(
                  'Consultar Árvore',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
