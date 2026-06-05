import 'package:flutter/material.dart';
import 'review_alert_screen.dart';

class EmergencyMessageGeneratorScreen extends StatefulWidget {
  final String emergencyType;

  const EmergencyMessageGeneratorScreen({
    super.key,
    required this.emergencyType,
  });

  @override
  State<EmergencyMessageGeneratorScreen> createState() =>
      _EmergencyMessageGeneratorScreenState();
}

class _EmergencyMessageGeneratorScreenState
    extends State<EmergencyMessageGeneratorScreen> {

  final TextEditingController noteController =
      TextEditingController();

  List<String> selectedTags = [];

  List<String> getTags() {

  switch (widget.emergencyType) {

    case "Medical":
      return [
        "Need Ambulance",
        "Severe Injury",
        "Unconscious Person",
        "Breathing Problem",
        "Heavy Bleeding",
        "Heart Emergency",
      ];

    case "Police":
      return [
        "Theft",
        "Assault",
        "Harassment",
        "Suspicious Activity",
        "Need Police Assistance",
      ];

    case "Fire":
      return [
        "Fire Detected",
        "Smoke Present",
        "Building Fire",
        "Person Trapped",
        "Need Fire Service",
      ];

    case "Danger":
      return [
        "Being Followed",
        "Unsafe Area",
        "Threat Detected",
        "Need Immediate Help",
      ];

    case "SOS":
      return [
        "Critical Situation",
        "Need Help",
        "Emergency Assistance",
        "Contact Me Immediately",
      ];

    default:
      return [];
  }
}
  void toggleTag(String tag) {
    setState(() {
      if (selectedTags.contains(tag)) {
        selectedTags.remove(tag);
      } else {
        selectedTags.add(tag);
      }
    });
  }

  String generateMessage() {
    String message =
        "${widget.emergencyType.toUpperCase()} EMERGENCY\n\n";

    for (var tag in selectedTags) {
      message += "$tag\n";
    }

    if (noteController.text.isNotEmpty) {
      message +=
          "\nAdditional Information:\n${noteController.text}";
    }

    message += "\n\nPlease respond immediately.";

    return message;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Generate Message"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [

            Text(
  "${widget.emergencyType} Emergency Details",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            Wrap(
              spacing: 8,
              children: getTags().map((tag) {
                return FilterChip(
                  label: Text(tag),
                  selected: selectedTags.contains(tag),
                  onSelected: (_) {
                    toggleTag(tag);
                  },
                );
              }).toList(),
            ),

            const SizedBox(height: 20),

            TextField(
              controller: noteController,
              maxLines: 4,
              decoration: const InputDecoration(
                labelText: "Additional Information",
                border: OutlineInputBorder(),
              ),
            ),

            const Spacer(),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  String finalMessage = generateMessage();

Navigator.push(
  context,
  MaterialPageRoute(
    builder: (_) => ReviewAlertScreen(
      emergencyType: widget.emergencyType,
      selectedTags: selectedTags,
      note: noteController.text,
      generatedMessage: finalMessage,
    ),
  ),
);
                },
                child: const Text(
                  "Generate Message",
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}