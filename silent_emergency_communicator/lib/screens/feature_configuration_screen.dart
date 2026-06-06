import 'package:flutter/material.dart';

class FeatureConfigurationScreen extends StatefulWidget {
  const FeatureConfigurationScreen({super.key});

  @override
  State<FeatureConfigurationScreen> createState() =>
      _FeatureConfigurationScreenState();
}

class _FeatureConfigurationScreenState
    extends State<FeatureConfigurationScreen> {

  bool silentMode = true;
  bool vibrationFeedback = true;

  void comingSoon() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("This feature will be added later."),
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
  foregroundColor: Colors.black,
  title: const Text(
    "Feature Configuration",
    style: TextStyle(
      fontWeight: FontWeight.bold,
    ),
  ),
),
      body: SingleChildScrollView(
  padding: const EdgeInsets.all(16),

  child: Column(
    children: [

      // HEADER CARD

      Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20),

        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius:
              BorderRadius.circular(24),

          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 8,
              offset: Offset(0, 4),
            ),
          ],
        ),

        child: Column(
          children: [

            CircleAvatar(
              radius: 40,
              backgroundColor:
                  Colors.red.shade50,

              child: Icon(
                Icons.settings,
                size: 40,
                color: Colors.red.shade700,
              ),
            ),

            const SizedBox(height: 16),

            const Text(
              "Emergency Settings",
              style: TextStyle(
                fontSize: 22,
                fontWeight:
                    FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),

            Text(
              "Configure how emergency alerts behave on your device.",
              textAlign: TextAlign.center,
              style: TextStyle(
                color:
                    Colors.grey.shade600,
              ),
            ),
          ],
        ),
      ),

      const SizedBox(height: 20),

      // SETTINGS CARD

      Container(
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(24),
    boxShadow: const [
      BoxShadow(
        color: Colors.black12,
        blurRadius: 8,
        offset: Offset(0, 4),
      ),
    ],
  ),

  child: Material(
    color: Colors.white,
    borderRadius: BorderRadius.circular(24),

    child: Column(
      children: [

        SwitchListTile(
          secondary: Icon(
            Icons.notifications_off,
            color: Colors.red.shade700,
          ),
          title: const Text(
            "Silent Emergency Mode",
          ),
          subtitle: const Text(
            "Send alerts without sounds",
          ),
          value: silentMode,
          activeColor: Colors.red.shade700,
          onChanged: (value) {
            setState(() {
              silentMode = value;
            });
          },
        ),

        const Divider(height: 1),

        SwitchListTile(
          secondary: Icon(
            Icons.vibration,
            color: Colors.red.shade700,
          ),
          title: const Text(
            "Vibration Feedback",
          ),
          subtitle: const Text(
            "Provide vibration confirmation",
          ),
          value: vibrationFeedback,
          activeColor: Colors.red.shade700,
          onChanged: (value) {
            setState(() {
              vibrationFeedback = value;
            });
          },
        ),
      ],
    ),
  ),
),

      const SizedBox(height: 20),

      // COMING SOON CARD

     Container(
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(24),
    boxShadow: const [
      BoxShadow(
        color: Colors.black12,
        blurRadius: 8,
        offset: Offset(0, 4),
      ),
    ],
  ),
  child: Material(
    color: Colors.white,
    borderRadius: BorderRadius.circular(24),
    child: Column(
      children: [
        ListTile(
          leading: Icon(
            Icons.phone_android,
            color: Colors.red.shade700,
          ),
          title: const Text(
            "Hardware Shortcut Activation",
          ),
          subtitle: const Text(
            "Coming Soon",
          ),
          trailing: const Icon(
            Icons.chevron_right,
          ),
          onTap: comingSoon,
        ),

        const Divider(height: 1),

        ListTile(
          leading: Icon(
            Icons.language,
            color: Colors.red.shade700,
          ),
          title: const Text(
            "Multilingual Support",
          ),
          subtitle: const Text(
            "Coming Soon",
          ),
          trailing: const Icon(
            Icons.chevron_right,
          ),
          onTap: comingSoon,
        ),
      ],
    ),
  ),
)
    ],
  ),
),
    );
  }
}