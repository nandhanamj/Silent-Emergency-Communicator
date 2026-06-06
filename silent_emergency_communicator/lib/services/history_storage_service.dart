import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../models/emergency_history.dart';

class HistoryStorageService {
  static const String key =
      "emergency_history";

  static Future<void> saveHistory(
      EmergencyHistory history) async {
    final prefs =
        await SharedPreferences.getInstance();

    List<String> histories =
        prefs.getStringList(key) ?? [];

    histories.add(
      jsonEncode(history.toJson()),
    );

    await prefs.setStringList(
      key,
      histories,
    );
  }

  static Future<List<EmergencyHistory>>
      getHistories() async {
    final prefs =
        await SharedPreferences.getInstance();

    final histories =
        prefs.getStringList(key) ?? [];

    return histories
        .map(
          (item) => EmergencyHistory.fromJson(
            jsonDecode(item),
          ),
        )
        .toList();
  }
}