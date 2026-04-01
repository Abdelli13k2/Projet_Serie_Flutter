import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/serie.dart';

class PreferencesService {
  static const _key = 'favoris';

  Future<List<Serie>> getFavoris() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonStr = prefs.getString(_key);

    if (jsonStr == null) return [];

    final List data = jsonDecode(jsonStr);
    return data.map((e) => Serie.fromJson(e)).toList();
  }

  Future<void> saveFavoris(List<Serie> favoris) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonStr =
        jsonEncode(favoris.map((s) => s.toJson()).toList());

    await prefs.setString(_key, jsonStr);
  }
}