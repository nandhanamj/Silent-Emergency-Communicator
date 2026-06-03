import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  static Future<void> saveUserProfile({
    required String fullName,
    required String phoneNumber,
    required String bloodGroup,
    required String medicalNotes,
    required String additionalInfo,
  }) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString('fullName', fullName);
    await prefs.setString('phoneNumber', phoneNumber);
    await prefs.setString('bloodGroup', bloodGroup);
    await prefs.setString('medicalNotes', medicalNotes);
    await prefs.setString('additionalInfo', additionalInfo);
  }
  static Future<Map<String, String>> getUserProfile() async {
  final prefs = await SharedPreferences.getInstance();

  return {
    'fullName': prefs.getString('fullName') ?? '',
    'phoneNumber': prefs.getString('phoneNumber') ?? '',
    'bloodGroup': prefs.getString('bloodGroup') ?? '',
    'medicalNotes': prefs.getString('medicalNotes') ?? '',
    'additionalInfo': prefs.getString('additionalInfo') ?? '',
  };
}
}