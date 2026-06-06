import 'package:flutter/material.dart';
import '../services/storage_service.dart';
import '../services/auto_sos_service.dart';
import 'emergency_processing_screen.dart';
import 'emergency_history_screen.dart';
import 'language_screen.dart';
import 'profile_screen.dart';
import 'emergency_contacts_screen.dart';
import 'emergency_messages_screen.dart';
import 'feature_configuration_screen.dart';

class EmergencyDashboardScreen extends StatefulWidget {
  const EmergencyDashboardScreen({super.key});

  @override
  State<EmergencyDashboardScreen> createState() =>
      _EmergencyDashboardScreenState();
}

class _EmergencyDashboardScreenState
    extends State<EmergencyDashboardScreen> {
      bool isOnline = true;
  String userName = "User";

  @override
void initState() {
super.initState();
loadUser();
}

  Future<void> loadUser() async {
    final profile =
        await StorageService.getUserProfile();

    setState(() {
      userName =
          profile["fullName"]?.isNotEmpty == true
              ? profile["fullName"]!
              : "User";
    });
  }

  void showEmergencyDialog(
    BuildContext context,
    String title,
  ) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text(
            "Confirm Emergency",
          ),
          content: Text(
            "Send $title Emergency Alert?",
          ),
          actions: [
            TextButton(
              onPressed: () =>
                  Navigator.pop(context),
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) =>
                        EmergencyProcessingScreen(
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
  String title,
  IconData icon,
  Color color,
) {
  return GestureDetector(
    onTap: () {
      if (!isOnline) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              "No internet connection available",
            ),
          ),
        );
        return;
      }

      showEmergencyDialog(
        context,
        title,
      );
    },
    child: Container(
      decoration: BoxDecoration(
        color: color.withOpacity(0.08),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: color.withOpacity(0.35),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.08),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 48,
            color: color,
          ),

          const SizedBox(height: 10),

          Text(
            title,
            style: TextStyle(
              color: color,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 4),

          const Text(
            "Emergency",
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    ),
  );
}

  Widget quickAction(
    IconData icon,
    String title,
    VoidCallback onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Chip(
        avatar: Icon(
          icon,
          size: 18,
        ),
        label: Text(title),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
  backgroundColor: const Color(0xFFF8F9FC),
      appBar: AppBar(
  elevation: 0,
  backgroundColor: Colors.white,
  foregroundColor: Colors.black87,
  centerTitle: true,
  title: const Text(
    "Silent Emergency",
    style: TextStyle(
      fontWeight: FontWeight.bold,
    ),
  ),
),

      // ---------------- DRAWER ----------------

      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            UserAccountsDrawerHeader(
              decoration:
                  const BoxDecoration(
                color: Colors.red,
              ),
              accountName:
                  Text(userName),
              accountEmail:
                  const Text(
                "Silent Emergency Communicator",
              ),
              currentAccountPicture:
                  const CircleAvatar(
                child: Icon(
                  Icons.person,
                  size: 40,
                ),
              ),
            ),

            ListTile(
              leading:
                  const Icon(Icons.person),
              title:
                  const Text("Profile"),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) =>
                        const ProfileScreen(),
                  ),
                );
              },
            ),

            ListTile(
              leading:
                  const Icon(Icons.contacts),
              title: const Text(
                "Emergency Contacts",
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) =>
                        const EmergencyContactsScreen(),
                  ),
                );
              },
            ),

            ListTile(
              leading:
                  const Icon(Icons.message),
              title: const Text(
                "Emergency Messages",
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) =>
                        const EmergencyMessagesScreen(),
                  ),
                );
              },
            ),

            ListTile(
              leading:
                  const Icon(Icons.history),
              title: const Text(
                "Emergency History",
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) =>
                        const EmergencyHistoryScreen(),
                  ),
                );
              },
            ),

            ListTile(
              leading:
                  const Icon(Icons.language),
              title:
                  const Text("Language"),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) =>
                        const LanguageScreen(),
                  ),
                );
              },
            ),

            ListTile(
              leading:
                  const Icon(Icons.settings),
              title: const Text(
                "Feature Settings",
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) =>
                        const FeatureConfigurationScreen(),
                  ),
                );
              },
            ),
          ],
        ),
      ),

      // ---------------- BODY ----------------

  body: Column(
children: [

if (!isOnline)
  Container(
    width: double.infinity,
    padding: const EdgeInsets.all(10),
    color: Colors.red,
    child: const Row(
      mainAxisAlignment:
          MainAxisAlignment.center,
      children: [
        Icon(
          Icons.wifi_off,
          color: Colors.white,
        ),
        SizedBox(width: 8),
        Text(
          "Offline Mode",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    ),
  ),
Container(
  width: double.infinity,
  margin: const EdgeInsets.all(16),
  padding: const EdgeInsets.all(20),
  decoration: BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(24),
    boxShadow: const [
      BoxShadow(
        color: Colors.black12,
        blurRadius: 12,
        offset: Offset(0, 4),
      ),
    ],
  ),
  child: Row(
    children: [
      CircleAvatar(
        radius: 28,
        backgroundColor: Colors.red.shade50,
        child: Icon(
          Icons.health_and_safety,
          color: Colors.red.shade700,
          size: 34,
        ),
      ),

      const SizedBox(width: 16),

      Expanded(
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,
          children: [
            Text(
              "Welcome, $userName",
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 4),

            Text(
              isOnline
                  ? "Emergency System Ready"
                  : "Offline Mode Active",
              style: TextStyle(
                color: isOnline
                    ? Colors.green
                    : Colors.red,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    ],
  ),
),
Expanded(
  child: Column(
    children: [

      Expanded(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: GridView.count(
            crossAxisCount: 2,
            childAspectRatio: 1.05,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            children: [
              emergencyCard(
                "Medical",
                Icons.medical_services,
                Colors.red,
              ),
              emergencyCard(
                "Police",
                Icons.local_police,
                Colors.blue,
              ),
              emergencyCard(
                "Fire",
                Icons.local_fire_department,
                Colors.orange,
              ),
              emergencyCard(
                "Danger",
                Icons.warning,
                Colors.amber,
              ),
              emergencyCard(
                "Panic",
                Icons.sos,
                Colors.red.shade900,
              ),
            ],
          ),
        ),
      ),

      Padding(
        padding: const EdgeInsets.fromLTRB(
          16,
          0,
          16,
          16,
        ),
        child: SizedBox(
          width: double.infinity,
          height: 65,
          child: ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
  backgroundColor: Colors.red.shade800,

  elevation: 8,

  shadowColor: Colors.redAccent,

  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(20),
  ),
),
icon: const Icon(
  Icons.sos,
  color: Colors.white,
  size: 28,
),
label: const Text(
  "Auto SOS",
  style: TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  ),
),
            onPressed: () async {
              try {
                await AutoSOSService.sendSOS();

                if (!mounted) return;

                ScaffoldMessenger.of(context)
                    .showSnackBar(
                  const SnackBar(
                    content: Text(
                      "SOS Alert Prepared Successfully",
                    ),
                  ),
                );
              } catch (e) {
                if (!mounted) return;

                ScaffoldMessenger.of(context)
                    .showSnackBar(
                  SnackBar(
                    content: Text(
                      e.toString(),
                    ),
                  ),
                );
              }
            },
          ),
        ),
      ),
    ],
  ),
),
      ],
    ),
  );
}
}