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
      appBar: AppBar(
        title: const Text("Feature Configuration"),
      ),
      body: ListView(
        children: [

          SwitchListTile(
            title: const Text("Silent Emergency Mode"),
            subtitle: const Text(
              "Send alerts without sounds",
            ),
            value: silentMode,
            onChanged: (value) {
              setState(() {
                silentMode = value;
              });
            },
          ),

          SwitchListTile(
            title: const Text("Vibration Feedback"),
            subtitle: const Text(
              "Provide vibration confirmation",
            ),
            value: vibrationFeedback,
            onChanged: (value) {
              setState(() {
                vibrationFeedback = value;
              });
            },
          ),

          const Divider(),

          ListTile(
            leading: const Icon(Icons.phone_android),
            title: const Text("Hardware Shortcut Activation"),
            subtitle: const Text("Coming Soon"),
            onTap: comingSoon,
          ),

          ListTile(
            leading: const Icon(Icons.language),
            title: const Text("Multilingual Support"),
            subtitle: const Text("Coming Soon"),
            onTap: comingSoon,
          ),
        ],
      ),
    );
  }
}