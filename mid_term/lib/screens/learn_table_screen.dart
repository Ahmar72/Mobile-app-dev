import 'package:flutter/material.dart';

class LearnTableScreen extends StatelessWidget {
  const LearnTableScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select item to learn'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildTableRow(['x1', 'x2', 'x3']),
            const SizedBox(height: 16),
            _buildTableRow(['x4', 'x5', 'x6']),
            const SizedBox(height: 16),
            _buildPlaceholderRow(),
            const SizedBox(height: 16),
            _buildTableRow(['x7', 'x8', 'x9']),
            const SizedBox(height: 16),
            _buildTableRow(['x10', 'x11', 'x12']),
            const SizedBox(height: 16),
            _buildTableRow(['x13', 'x14', 'x15']),
          ],
        ),
      ),
    );
  }

  Widget _buildTableRow(List<String> tables) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: tables.map((table) => _buildTableButton(table)).toList(),
    );
  }

  Widget _buildTableButton(String table) {
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(80, 80),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      child: Text(
        table,
        style: const TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildPlaceholderRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildPlaceholder('Google Play'),
        _buildPlaceholder('SCREW PUZZLE'),
      ],
    );
  }

  Widget _buildPlaceholder(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(text),
    );
  }
}