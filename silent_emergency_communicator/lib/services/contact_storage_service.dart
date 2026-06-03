import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../models/emergency_contact.dart';

class ContactStorageService {
  static const String contactsKey = 'emergency_contacts';

  static Future<void> saveContacts(
    List<EmergencyContact> contacts,
  ) async {
    final prefs = await SharedPreferences.getInstance();

    final encoded = contacts
        .map((contact) => jsonEncode(contact.toJson()))
        .toList();

    await prefs.setStringList(contactsKey, encoded);
  }

  static Future<List<EmergencyContact>> getContacts() async {
    final prefs = await SharedPreferences.getInstance();

    final stored =
        prefs.getStringList(contactsKey) ?? [];

    return stored.map((item) {
      return EmergencyContact.fromJson(
        jsonDecode(item),
      );
    }).toList();
  }
}