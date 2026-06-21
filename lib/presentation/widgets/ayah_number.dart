import 'package:flutter/material.dart';

class AyahNumber extends StatelessWidget {
  final int number;

  const AyahNumber({super.key, required this.number});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: const Color(0xFFFFD700).withOpacity(0.3),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFFFD700), width: 1),
      ),
      child: Text(
        '($number)',
        style: const TextStyle(
          fontSize: 14,
          color: Color(0xFFB8860B),
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
