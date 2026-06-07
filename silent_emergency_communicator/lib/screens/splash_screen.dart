import 'dart:async';
import 'package:flutter/material.dart';

import '../services/storage_service.dart';
import 'registration_screen.dart';
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

    final profile = await StorageService.getUserProfile();

debugPrint("PROFILE DATA: $profile");    

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
      body: Container(
        width: double.infinity,
        height: double.infinity,

        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFFE53935),
              Color(0xFFB71C1C),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),

        child: Center(
          child: Column(
            mainAxisAlignment:
                MainAxisAlignment.center,

            children: [

              const Icon(
                Icons.health_and_safety_rounded,
                size: 100,
                color: Colors.white,
              ),

              const SizedBox(height: 30),

              const Text(
                "Silent Emergency\nCommunicator",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.5,
                ),
              ),

              const SizedBox(height: 12),

              const Text(
                "Your safety. One silent tap away.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 15,
                ),
              ),

              const SizedBox(height: 50),

              const SizedBox(
                width: 32,
                height: 32,
                child: CircularProgressIndicator(
                  color: Colors.white,
                  strokeWidth: 3,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}