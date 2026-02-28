import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguageProvider extends ChangeNotifier {
  static const _prefKey = 'app_language_code';

  Locale _locale = const Locale('en');
  Locale get locale => _locale;
  bool get isHindi => _locale.languageCode == 'hi';

  LanguageProvider() {
    _load();
  }

  Future<void> _load() async {
    final prefs = await SharedPreferences.getInstance();
    final code = prefs.getString(_prefKey) ?? 'en';
    _locale = Locale(code);
    notifyListeners();
  }

  Future<void> switchLanguage(String languageCode) async {
    if (_locale.languageCode == languageCode) return;
    _locale = Locale(languageCode);
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_prefKey, languageCode);
  }
}
