import 'package:flutter/material.dart';
import 'package:frontend_flutter/models/json_viewer.dart';
import 'package:provider/provider.dart';
import '../services/api_service.dart';
import '../providers/auth_provider.dart';

class TreePage extends StatefulWidget {
  const TreePage({super.key});

  @override
  State<TreePage> createState() => _TreePageState();
}

class _TreePageState extends State<TreePage> {
  final TextEditingController _siteIdController = TextEditingController();
  bool _loading = false;
  dynamic _treeData;
  String? _error;

  Future<void> _fetchTree() async {
    final token = Provider.of<AuthProvider>(context, listen: false).token;
    final siteId = int.tryParse(_siteIdController.text);

    if (siteId == null) {
      setState(() => _error = 'Insira um ID de site válido.');
      return;
    }

    setState(() {
      _loading = true;
      _error = null;
      _treeData = null;
    });

    try {
      final data = await ApiService.getTree(token, siteId);
      setState(() => _treeData = data);
    } catch (e) {
      setState(() => _error = 'Erro ao buscar árvore: $e');
    } finally {
      setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Consultar Árvore',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w200),
        ),
        backgroundColor: Color(0xFF0C113D),
        iconTheme: const IconThemeData(color: Colors.white),
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: _siteIdController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'ID do site'),
            ),
            const SizedBox(height: 20),
            _loading
                ? const CircularProgressIndicator()
                : ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll(Color(0xFF0C113D)),
                  ),
                  onPressed: _fetchTree,
                  child: const Text(
                    'Buscar',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
            const SizedBox(height: 20),
            if (_error != null)
              Text(_error!, style: const TextStyle(color: Colors.red)),
            if (_treeData != null) Expanded(child: JsonViewer(_treeData)),
          ],
        ),
      ),
    );
  }
}
