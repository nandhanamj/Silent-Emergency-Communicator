import 'dart:async';
import 'package:flutter/material.dart';
import 'registration_screen.dart';
import '../services/storage_service.dart';
import 'emergency_dashboard_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

 @override
void initState() {
  super.initState();
  checkRegistration();
}
Future<void> checkRegistration() async {
  await Future.delayed(
    const Duration(seconds: 2),
  );

  final profile =
      await StorageService.getUserProfile();

  if (!mounted) return;

  if ((profile['fullName'] ?? '').isEmpty) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) =>
            const RegistrationScreen(),
      ),
    );
  } else {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) =>
            const EmergencyDashboardScreen(),
      ),
    );
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(
              Icons.health_and_safety,
              color: Colors.white,
              size: 90,
            ),
            SizedBox(height: 20),
            Text(
              'Silent Emergency\nCommunicator',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}