import 'package:shared_preferences/shared_preferences.dart';

class LanguageService {
  static const key = "language";

  static Future<void> saveLanguage(
    String language,
  ) async {
    final prefs =
        await SharedPreferences.getInstance();

    await prefs.setString(
      key,
      language,
    );
  }

  static Future<String> getLanguage() async {
    final prefs =
        await SharedPreferences.getInstance();

    return prefs.getString(key) ??
        "English";
  }
}