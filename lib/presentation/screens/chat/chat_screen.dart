import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0E27),
      body: const Center(
        child: Text(
          '💬 المحادثة الذكية',
          style: TextStyle(color: Color(0xFFFFD700), fontSize: 24, fontFamily: 'Amiri'),
        ),
      ),
    );
  }
}
