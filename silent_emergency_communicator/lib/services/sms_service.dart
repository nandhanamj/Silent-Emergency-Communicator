import 'package:url_launcher/url_launcher.dart';

class SmsService {
  static Future<void> sendSms(
    String phoneNumber,
    String message,
  ) async {

    final Uri uri = Uri.parse(
      'sms:$phoneNumber?body=${Uri.encodeComponent(message)}',
    );

    await launchUrl(uri);
  }
}