class BookmarkService {
  static Future<void> addBookmark(int surah, int ayah, String text) async {
    print('📖 تمت الإضافة للمفضلة: سورة $surah آية $ayah');
  }
}
