import 'package:flutter/material.dart';
import '../../../services/page_builder_service.dart';
import '../../../domain/models/quran_page.dart';
import '../../../services/bookmark_service.dart';
import '../../widgets/ayah_number.dart';
import '../../widgets/surah_banner.dart';

class MushafScreen extends StatefulWidget {
  const MushafScreen({super.key});

  @override
  State<MushafScreen> createState() => _MushafScreenState();
}

class _MushafScreenState extends State<MushafScreen> {
  final PageController _pc = PageController(initialPage: 0);
  int _page = 1;
  bool _bars = true;
  int? _hl;
  late Future<Map<int, List<AyahData>>> _futurePages;
  Map<int, List<AyahData>>? _cachedPages;

  @override
  void initState() {
    super.initState();
    _futurePages = _loadPages();
  }

  Future<Map<int, List<AyahData>>> _loadPages() async {
    try {
      final pages = await PageBuilderService.buildPages();
      _cachedPages = pages;
      return pages;
    } catch (e) {
      throw Exception('فشل تحميل بيانات المصحف: $e');
    }
  }

  @override
  void dispose() {
    _pc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0E27),
      body: FutureBuilder<Map<int, List<AyahData>>>(
        future: _futurePages,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(color: Color(0xFFFFD700)),
            );
          }
          if (snapshot.hasError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline, color: Color(0xFFFFD700), size: 60),
                  const SizedBox(height: 16),
                  Text(
                    '⚠️ ${snapshot.error}',
                    style: const TextStyle(color: Colors.white70, fontSize: 16),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _futurePages = _loadPages();
                      });
                    },
                    style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFFFD700)),
                    child: const Text(
                      'إعادة المحاولة',
                      style: TextStyle(color: Color(0xFF0A0E27)),
                    ),
                  ),
                ],
              ),
            );
          }
          final pages = snapshot.data!;
          final keys = pages.keys.toList()..sort();

          return SafeArea(
            child: Stack(
              children: [
                GestureDetector(
                  onTap: () => setState(() => _bars = !_bars),
                  child: PageView.builder(
                    controller: _pc,
                    itemCount: keys.length,
                    reverse: true,
                    onPageChanged: (i) {
                      setState(() {
                        _page = keys[i];
                        _hl = null;
                      });
                    },
                    itemBuilder: (_, i) => _buildPage(keys[i], pages[keys[i]] ?? [], pages),
                  ),
                ),
                if (_bars) _topBar(pages),
                if (_bars) _bottomBar(),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _topBar(Map<int, List<AyahData>> pages) {
    final surahName = _getSurahName(_page, pages);
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        color: const Color(0xFF1A237E).withOpacity(0.95),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'الجزء ${PageBuilderService.getJuz(_page)}',
              style: const TextStyle(color: Color(0xFFFFD700), fontFamily: 'Amiri'),
            ),
            Text(
              surahName,
              style: const TextStyle(
                color: Color(0xFFFFD700),
                fontFamily: 'Amiri',
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _bottomBar() => Positioned(
        bottom: 0,
        left: 0,
        right: 0,
        child: Container(
          padding: const EdgeInsets.all(12),
          color: const Color(0xFF1A237E).withOpacity(0.95),
          child: Center(
            child: Text(
              'صفحة $_page / 604',
              style: const TextStyle(color: Color(0xFFFFD700), fontFamily: 'Amiri'),
            ),
          ),
        ),
      );

  Widget _buildPage(
    int pn,
    List<AyahData> verses,
    Map<int, List<AyahData>> allPages,
  ) {
    final isNew = verses.isNotEmpty && verses.first.ayahNumber == 1;
    return Container(
      margin: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: const Color(0xFFFDF9F3),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: const Color(0xFFFFD700).withOpacity(0.4), width: 2),
        boxShadow: [
          BoxShadow(color: const Color(0xFFB8860B).withOpacity(0.15), blurRadius: 8),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        child: Column(
          children: [
            if (isNew)
              SurahBanner(
                surahName: _getSurahName(pn, allPages),
                showBismillah: pn != 1,
              ),
            Expanded(
              child: ListView.builder(
                itemCount: verses.length,
                itemBuilder: (_, i) {
                  final a = verses[i];
                  final hl = _hl == a.ayahNumber;
                  return GestureDetector(
                    onTap: () => setState(() => _hl = hl ? null : a.ayahNumber),
                    onLongPress: () async {
                      await BookmarkService.addBookmark(
                        a.surahNumber,
                        a.ayahNumber,
                        a.text,
                      );
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('✅ تمت الإضافة للمفضلة'),
                          backgroundColor: Color(0xFFFFD700),
                        ),
                      );
                    },
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      margin: const EdgeInsets.only(bottom: 1),
                      padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 1),
                      decoration: BoxDecoration(
                        color: hl
                            ? const Color(0xFFFFD700).withOpacity(0.25)
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: RichText(
                        textAlign: TextAlign.justify,
                        textDirection: TextDirection.rtl,
                        text: TextSpan(
                          style: const TextStyle(
                            fontFamily: 'Amiri',
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF2C1810),
                            height: 2.0,
                          ),
                          children: [
                            TextSpan(text: a.text),
                            WidgetSpan(child: AyahNumber(number: a.ayahNumber)),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _getSurahName(int pageNumber, Map<int, List<AyahData>> allPages) {
    final verses = allPages[pageNumber];
    if (verses == null || verses.isEmpty) return '';
    final surahNum = verses.first.surahNumber;
    return PageBuilderService.getSurahName(surahNum);
  }
}
