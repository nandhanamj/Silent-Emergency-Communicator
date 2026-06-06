import 'package:flutter/material.dart';
import 'emergency_processing_screen.dart';
import 'emergency_history_screen.dart';
import 'language_screen.dart';
import 'profile_screen.dart';

class EmergencyDashboardScreen extends StatelessWidget {
  const EmergencyDashboardScreen({super.key});

  void showEmergencyDialog(
    BuildContext context,
    String title,
  ) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Confirm Alert"),
          content: Text(
            "Send $title Emergency Alert?",
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () {
  Navigator.pop(context);

  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (_) => EmergencyProcessingScreen(
        emergencyType: title,
      ),
    ),
  );
},
              child: const Text("Send"),
            ),
          ],
        );
      },
    );
  }

  Widget emergencyCard(
    BuildContext context,
    String title,
    IconData icon,
    Color color,
  ) {
    return GestureDetector(
      onTap: () {
        showEmergencyDialog(context, title);
      },
      child: Card(
        elevation: 4,
        color: color,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 50,
                color: Colors.white,
              ),
              const SizedBox(height: 10),
              Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
  title: const Text(
    "Emergency Dashboard",
  ),
  actions: [

    IconButton(
      icon: const Icon(
        Icons.history,
      ),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) =>
                const EmergencyHistoryScreen(),
          ),
        );
      },
    ),

    IconButton(
  icon: const Icon(Icons.person),
  onPressed: () {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) =>
            const ProfileScreen(),
      ),
    );
  },
),

    IconButton(
      icon: const Icon(
        Icons.language,
      ),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) =>
                const LanguageScreen(),
          ),
        );
      },
    ),

  ],
),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          children: [

            emergencyCard(
              context,
              "Medical",
              Icons.medical_services,
              Colors.red,
            ),

            emergencyCard(
              context,
              "Police",
              Icons.local_police,
              Colors.blue,
            ),

            emergencyCard(
              context,
              "Fire",
              Icons.local_fire_department,
              Colors.orange,
            ),

            emergencyCard(
              context,
              "Danger",
              Icons.warning,
              Colors.amber,
            ),

            emergencyCard(
              context,
              "SOS",
              Icons.sos,
              Colors.red.shade900,
            ),
          ],
        ),
      ),
    );
  }
}