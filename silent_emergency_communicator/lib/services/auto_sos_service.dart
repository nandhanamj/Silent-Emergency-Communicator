import '../models/emergency_contact.dart';
import '../models/emergency_history.dart';

import 'contact_storage_service.dart';
import 'history_storage_service.dart';
import 'location_service.dart';
import 'sms_service.dart';
import 'storage_service.dart';

class AutoSOSService {
  static Future<void> sendSOS() async {

    final profile =
        await StorageService.getUserProfile();

    final contacts =
        await ContactStorageService.getContacts();

    if (contacts.isEmpty) {
      throw Exception(
        "No emergency contacts found",
      );
    }

    final location =
        await LocationService.getCurrentLocation();

    String locationLink =
        "Location unavailable";

    if (location != null) {
      locationLink =
          "https://maps.google.com/?q=${location.latitude},${location.longitude}";
    }

    final message = '''
🚨 SOS EMERGENCY 🚨

Name: ${profile["fullName"]}

Phone: ${profile["phoneNumber"]}

Blood Group: ${profile["bloodGroup"]}

Location:
$locationLink

Please help immediately.
''';

    final phoneNumbers =
        contacts.map((e) => e.phoneNumber).join(',');

    await SmsService.sendSms(
      phoneNumbers,
      message,
    );

    final history = EmergencyHistory(
      emergencyType: "SOS",
      dateTime: DateTime.now().toString(),
      message: message,
      recipients:
          contacts.map((e) => e.phoneNumber).toList(),
    );

    await HistoryStorageService.saveHistory(
      history,
    );
  }
}