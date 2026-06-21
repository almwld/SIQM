import 'dart:convert';
import 'package:flutter/services.dart';
import '../domain/models/quran_page.dart';

class PageBuilderService {
  static Future<Map<int, List<AyahData>>> buildPages() async {
    try {
      final jsonString = await rootBundle.loadString('assets/unified_quran.json');
      final List<dynamic> data = json.decode(jsonString);
      final Map<int, List<AyahData>> pages = {};
      for (var item in data) {
        final ayah = AyahData.fromJson(item);
        pages.putIfAbsent(ayah.page, () => []).add(ayah);
      }
      return pages;
    } catch (e) {
      throw Exception('فشل تحميل unified_quran.json: $e');
    }
  }

  static String getSurahName(int surahNumber) {
    const names = [
      'الفاتحة', 'البقرة', 'آل عمران', 'النساء', 'المائدة', 'الأنعام',
      'الأعراف', 'الأنفال', 'التوبة', 'يونس', 'هود', 'يوسف', 'الرعد',
      'إبراهيم', 'الحجر', 'النحل', 'الإسراء', 'الكهف', 'مريم', 'طه',
      'الأنبياء', 'الحج', 'المؤمنون', 'النور', 'الفرقان', 'الشعراء',
      'النمل', 'القصص', 'العنكبوت', 'الروم', 'لقمان', 'السجدة',
      'الأحزاب', 'سبأ', 'فاطر', 'يس', 'الصافات', 'ص', 'الزمر', 'غافر',
      'فصلت', 'الشورى', 'الزخرف', 'الدخان', 'الجاثية', 'الأحقاف',
      'محمد', 'الفتح', 'الحجرات', 'ق', 'الذاريات', 'الطور', 'النجم',
      'القمر', 'الرحمن', 'الواقعة', 'الحديد', 'المجادلة', 'الحشر',
      'الممتحنة', 'الصف', 'الجمعة', 'المنافقون', 'التغابن', 'الطلاق',
      'التحريم', 'الملك', 'القلم', 'الحاقة', 'المعارج', 'نوح', 'الجن',
      'المزمل', 'المدثر', 'القيامة', 'الإنسان', 'المرسلات', 'النبأ',
      'النازعات', 'عبس', 'التكوير', 'الانفطار', 'المطففين', 'الانشقاق',
      'البروج', 'الطارق', 'الأعلى', 'الغاشية', 'الفجر', 'البلد',
      'الشمس', 'الليل', 'الضحى', 'الشرح', 'التين', 'العلق', 'القدر',
      'البينة', 'الزلزلة', 'العاديات', 'القارعة', 'التكاثر', 'العصر',
      'الهمزة', 'الفيل', 'قريش', 'الماعون', 'الكوثر', 'الكافرون',
      'النصر', 'المسد', 'الإخلاص', 'الفلق', 'الناس'
    ];
    if (surahNumber >= 1 && surahNumber <= names.length) {
      return names[surahNumber - 1];
    }
    return '';
  }

  static int getJuz(int pageNumber) {
    if (pageNumber <= 20) return 1;
    if (pageNumber <= 40) return 2;
    if (pageNumber <= 60) return 3;
    if (pageNumber <= 80) return 4;
    if (pageNumber <= 100) return 5;
    if (pageNumber <= 120) return 6;
    if (pageNumber <= 140) return 7;
    if (pageNumber <= 160) return 8;
    if (pageNumber <= 180) return 9;
    if (pageNumber <= 200) return 10;
    if (pageNumber <= 220) return 11;
    if (pageNumber <= 240) return 12;
    if (pageNumber <= 260) return 13;
    if (pageNumber <= 280) return 14;
    if (pageNumber <= 300) return 15;
    if (pageNumber <= 320) return 16;
    if (pageNumber <= 340) return 17;
    if (pageNumber <= 360) return 18;
    if (pageNumber <= 380) return 19;
    if (pageNumber <= 400) return 20;
    if (pageNumber <= 420) return 21;
    if (pageNumber <= 440) return 22;
    if (pageNumber <= 460) return 23;
    if (pageNumber <= 480) return 24;
    if (pageNumber <= 500) return 25;
    if (pageNumber <= 520) return 26;
    if (pageNumber <= 540) return 27;
    if (pageNumber <= 560) return 28;
    if (pageNumber <= 580) return 29;
    return 30;
  }
}
