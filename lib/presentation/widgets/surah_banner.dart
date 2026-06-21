import 'package:flutter/material.dart';

class SurahBanner extends StatelessWidget {
  final String surahName;
  final bool showBismillah;

  const SurahBanner({
    super.key,
    required this.surahName,
    this.showBismillah = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF1A237E), Color(0xFF0A0E27)],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFFFD700), width: 2),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFFFD700).withOpacity(0.3),
            blurRadius: 8,
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            'سورة $surahName',
            style: const TextStyle(
              color: Color(0xFFFFD700),
              fontSize: 22,
              fontFamily: 'Amiri',
              fontWeight: FontWeight.bold,
            ),
          ),
          if (showBismillah) ...[
            const SizedBox(height: 4),
            const Text(
              'بِسْمِ اللَّهِ الرَّحْمَٰنِ الرَّحِيمِ',
              style: TextStyle(
                color: Color(0xFFFFD700),
                fontSize: 18,
                fontFamily: 'Amiri',
              ),
            ),
          ],
        ],
      ),
    );
  }
}
