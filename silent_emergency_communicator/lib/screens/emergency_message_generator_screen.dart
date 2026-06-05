import 'package:flutter/material.dart';

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

  final List<String> medicalTags = [
    "Need Ambulance",
    "Severe Injury",
    "Unconscious Person",
    "Breathing Problem",
    "Heavy Bleeding",
    "Heart Emergency",
  ];

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

            const Text(
              "Select Emergency Details",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            Wrap(
              spacing: 8,
              children: medicalTags.map((tag) {
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

                  String finalMessage =
                      generateMessage();

                  showDialog(
                    context: context,
                    builder: (_) => AlertDialog(
                      title: const Text(
                        "Generated Message",
                      ),
                      content: SingleChildScrollView(
                        child: Text(finalMessage),
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text("Close"),
                        ),
                      ],
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