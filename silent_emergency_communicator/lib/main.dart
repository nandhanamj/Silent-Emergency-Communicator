import 'package:flutter/material.dart';
import 'screens/splash_screen.dart';
import 'screens/emergency_messages_screen.dart';
import 'screens/feature_configuration_screen.dart';

void main() {
  runApp(const SilentEmergencyApp());
}

class SilentEmergencyApp extends StatelessWidget {
  const SilentEmergencyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Silent Emergency Communicator',
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.red,
      ),
      home:const SplashScreen(),
    );
  }
}