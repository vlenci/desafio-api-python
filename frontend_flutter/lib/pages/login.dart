import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/api_service.dart';
import '../providers/auth_provider.dart';
import 'home.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _username = TextEditingController();
  final TextEditingController _password = TextEditingController();
  bool _loading = false;

  Future<void> _login() async {
    setState(() => _loading = true);

    final token = await ApiService.login(
      _username.text.trim(),
      _password.text.trim(),
    );

    setState(() => _loading = false);

    if (token != null && token['access'] != null && token['refresh'] != null) {
      Provider.of<AuthProvider>(
        context,
        listen: false,
      ).setTokens(access: token['access'], refresh: token['refresh']);

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const HomePage()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Login inválido ou erro na API')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
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
              "Login",
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w300,
              ),
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: _username,
              decoration: const InputDecoration(labelText: 'Usuário'),
            ),
            TextField(
              controller: _password,
              decoration: const InputDecoration(labelText: 'Senha'),
              obscureText: true,
            ),
            const SizedBox(height: 20),
            _loading
                ? const CircularProgressIndicator()
                : ElevatedButton(
                  onPressed: _login,
                  style: ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll<Color>(
                      Color(0xFFe46c1c),
                    ),
                  ),
                  child: const Text(
                    'Entrar',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
          ],
        ),
      ),
    );
  }
}
