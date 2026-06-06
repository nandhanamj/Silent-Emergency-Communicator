import 'package:flutter/material.dart';
import 'screens/splash_screen.dart';
void main() {
  runApp(const SilentEmergencyApp());
}

class SilentEmergencyApp extends StatelessWidget {
  const SilentEmergencyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      theme: ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.red,

        elevatedButtonTheme:
            ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            minimumSize: const Size(
              double.infinity,
              60,
            ),
          ),
        ),
      ),

      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(
            textScaler:
                const TextScaler.linear(
              1.1,
            ),
          ),
          child: child!,
        );
      },

      home: const SplashScreen(),
    );
  }
}