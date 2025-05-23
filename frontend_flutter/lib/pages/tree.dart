import 'package:flutter/material.dart';
import 'package:frontend_flutter/models/json_viewer.dart';
import '../services/api_service.dart';

class TreePage extends StatefulWidget {
  const TreePage({super.key});

  @override
  State<TreePage> createState() => _TreePageState();
}

class _TreePageState extends State<TreePage> {
  final TextEditingController _siteIdController = TextEditingController();

  dynamic _treeData;
  bool _isLoading = false;
  String? _error;

  @override
  void initState() {
    super.initState();
    if (_siteIdController.text.isNotEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        fetchTree();
      });
    }
  }

  Future<void> fetchTree() async {
    final siteId = int.tryParse(_siteIdController.text);
    if (siteId == null) {
      setState(() {
        _error = 'Insira um ID de site válido.';
        _treeData = null;
      });
      return;
    }

    setState(() {
      _isLoading = true;
      _error = null;
      _treeData = null;
    });

    try {
      final data = await ApiService.getTree(context, siteId);
      setState(() {
        _treeData = data;
      });
    } catch (e) {
      setState(() {
        _error = 'Erro ao buscar árvore: $e';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
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
        backgroundColor: const Color(0xFF0C113D),
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
              onSubmitted: (_) => fetchTree(),
            ),
            const SizedBox(height: 20),
            _isLoading
                ? const CircularProgressIndicator()
                : ElevatedButton(
                  style: const ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll(Color(0xFF0C113D)),
                  ),
                  onPressed: fetchTree,
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
