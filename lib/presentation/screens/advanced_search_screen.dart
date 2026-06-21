import 'package:flutter/material.dart';

class AdvancedSearchScreen extends StatelessWidget {
  const AdvancedSearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0E27),
      appBar: AppBar(
        title: const Text('بحث متقدم', style: TextStyle(color: Color(0xFFFFD700))),
        backgroundColor: const Color(0xFF1A237E),
      ),
      body: const Center(
        child: Text(
          '🔍 البحث في القرآن',
          style: TextStyle(color: Color(0xFFFFD700), fontSize: 24, fontFamily: 'Amiri'),
        ),
      ),
    );
  }
}
