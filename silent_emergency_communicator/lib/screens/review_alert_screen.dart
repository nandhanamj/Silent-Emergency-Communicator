import 'package:flutter/material.dart';
import '../services/storage_service.dart';

class ReviewAlertScreen extends StatefulWidget {
  final String emergencyType;
  final List<String> selectedTags;
  final String note;
  final String generatedMessage;

  const ReviewAlertScreen({
    super.key,
    required this.emergencyType,
    required this.selectedTags,
    required this.note,
    required this.generatedMessage,
  });

  @override
  State<ReviewAlertScreen> createState() =>
      _ReviewAlertScreenState();
}
class _ReviewAlertScreenState
    extends State<ReviewAlertScreen> {

  Map<String, dynamic> profile = {};

  @override
  void initState() {
    super.initState();
    loadProfile();
  }

  Future<void> loadProfile() async {
    final data =
        await StorageService.getUserProfile();

    setState(() {
      profile = data;
    });
  }
  String buildFinalMessage() {
  String message =
      "${widget.emergencyType.toUpperCase()} EMERGENCY\n\n";

  message +=
      "Name: ${profile['fullName'] ?? ''}\n";

  message +=
      "Phone: ${profile['phoneNumber'] ?? ''}\n";

  message +=
      "Blood Group: ${profile['bloodGroup'] ?? ''}\n\n";

  for (var tag in widget.selectedTags) {
    message += "$tag\n";
  }

  if (widget.note.isNotEmpty) {
    message +=
        "\nAdditional Information:\n${widget.note}";
  }

  message +=
      "\n\nPlease respond immediately.";

  return message;
}
    @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Review Alert"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [

            // USER INFORMATION CARD

            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [

                    const Text(
                      "User Information",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 10),

                    Text(
                      "Name: ${profile['fullName'] ?? ''}",
                    ),

                    Text(
                      "Phone: ${profile['phoneNumber'] ?? ''}",
                    ),

                    Text(
                      "Blood Group: ${profile['bloodGroup'] ?? ''}",
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 12),

            // EMERGENCY TYPE

            Card(
              child: ListTile(
                leading: const Icon(Icons.warning),
                title: const Text("Emergency Type"),
                subtitle: Text(widget.emergencyType),
              ),
            ),

            const SizedBox(height: 12),

            // TAGS

            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [

                    const Text(
                      "Selected Tags",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 10),

                    ...widget.selectedTags.map(
                      (tag) => ListTile(
                        leading: const Icon(
                          Icons.check_circle,
                        ),
                        title: Text(tag),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 12),

            if (widget.note.isNotEmpty)
              Card(
                child: ListTile(
                  leading: const Icon(Icons.notes),
                  title: const Text(
                    "Additional Note",
                  ),
                  subtitle: Text(widget.note),
                ),
              ),

            const SizedBox(height: 12),

            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [

                    const Text(
                      "Generated Message",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 10),

                    Text(buildFinalMessage()),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                icon: const Icon(Icons.send),
                label: const Text(
                  "Confirm Alert",
                ),
                onPressed: () {
                  ScaffoldMessenger.of(context)
                      .showSnackBar(
                    const SnackBar(
                      content: Text(
                        "Alert Confirmed",
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}