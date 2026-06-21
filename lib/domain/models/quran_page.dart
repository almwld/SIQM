class AyahData {
  final int surahNumber;
  final int ayahNumber;
  final int page;
  final String text;

  AyahData({
    required this.surahNumber,
    required this.ayahNumber,
    required this.page,
    required this.text,
  });

  factory AyahData.fromJson(Map<String, dynamic> json) {
    return AyahData(
      surahNumber: json['surah'] ?? 0,
      ayahNumber: json['ayah'] ?? 0,
      page: json['page'] ?? 0,
      text: json['text'] ?? '',
    );
  }
}
