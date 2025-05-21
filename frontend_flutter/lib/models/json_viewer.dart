import 'package:flutter/material.dart';

class JsonViewer extends StatelessWidget {
  final dynamic json;
  const JsonViewer(this.json, {super.key});

  @override
  Widget build(BuildContext context) {
    return _buildJsonWidget(json);
  }

  Widget _buildJsonWidget(dynamic data) {
    if (data is Map<String, dynamic>) {
      return SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children:
              data.entries.map((entry) {
                return ExpansionTile(
                  title: Text(
                    entry.key,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 30),
                      child: _buildJsonWidget(entry.value),
                    ),
                  ],
                );
              }).toList(),
        ),
      );
    } else if (data is List) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children:
            data.asMap().entries.map((entry) {
              return ExpansionTile(
                title: Text('[${entry.key}]'),
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 16),
                    child: _buildJsonWidget(entry.value),
                  ),
                ],
              );
            }).toList(),
      );
    } else {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 2),
        child: Text(data.toString()),
      );
    }
  }
}
