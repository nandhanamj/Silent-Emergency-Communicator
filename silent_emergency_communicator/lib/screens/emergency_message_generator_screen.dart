import 'package:flutter/material.dart';
import 'review_alert_screen.dart';
import 'select_recipients_screen.dart';

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

  Color emergencyColor;

  switch (widget.emergencyType) {
    case "Medical":
      emergencyColor = Colors.red;
      break;

    case "Police":
      emergencyColor = Colors.blue;
      break;

    case "Fire":
      emergencyColor = Colors.orange;
      break;

    case "Danger":
      emergencyColor = Colors.amber.shade700;
      break;

    default:
      emergencyColor = Colors.red.shade900;
  }

  return Scaffold(
    backgroundColor: const Color(0xFFF8F9FC),

    appBar: AppBar(
      elevation: 0,
      backgroundColor: Colors.white,
      foregroundColor: Colors.black,
      title: const Text(
        "Generate Message",
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
    ),

    body: Padding(
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
                  radius: 38,
                  backgroundColor:
                      emergencyColor.withOpacity(0.1),

                  child: Icon(
                    Icons.warning_amber_rounded,
                    size: 40,
                    color: emergencyColor,
                  ),
                ),

                const SizedBox(height: 12),

                Text(
                  "${widget.emergencyType} Emergency",
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight:
                        FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 6),

                Text(
                  "Select emergency details and generate your alert message.",
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

          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,

                children: [

                  const Text(
                    "Emergency Tags",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight:
                          FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 12),

                  Wrap(
                    spacing: 10,
                    runSpacing: 10,

                    children:
                        getTags().map((tag) {

                      final selected =
                          selectedTags.contains(
                              tag);

                      return FilterChip(
                        label: Text(tag),

                        selected:
                            selected,

                        selectedColor:
                            emergencyColor
                                .withOpacity(
                                    0.2),

                        checkmarkColor:
                            emergencyColor,

                        labelStyle:
                            TextStyle(
                          color: selected
                              ? emergencyColor
                              : Colors.black87,
                          fontWeight:
                              FontWeight.w600,
                        ),

                        onSelected: (_) {
                          toggleTag(tag);
                        },
                      );
                    }).toList(),
                  ),

                  const SizedBox(height: 24),

                  const Text(
                    "Additional Information",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight:
                          FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 12),

                  Container(
                    decoration:
                        BoxDecoration(
                      color: Colors.white,
                      borderRadius:
                          BorderRadius
                              .circular(
                                  20),

                      boxShadow: const [
                        BoxShadow(
                          color:
                              Colors.black12,
                          blurRadius: 8,
                          offset:
                              Offset(0, 4),
                        ),
                      ],
                    ),

                    child: TextField(
                      controller:
                          noteController,

                      maxLines: 5,

                      decoration:
                          const InputDecoration(
                        hintText:
                            "Enter additional details here...",
                        border:
                            InputBorder.none,
                        contentPadding:
                            EdgeInsets.all(
                                16),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 15),

          SizedBox(
            width: double.infinity,
            height: 58,

            child: ElevatedButton.icon(
              icon: const Icon(
                Icons.send,
              ),

              style:
                  ElevatedButton.styleFrom(
                backgroundColor:
                    emergencyColor,

                foregroundColor:
                    Colors.white,

                shape:
                    RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(
                          18),
                ),
              ),

              onPressed: () {

                String finalMessage =
                    generateMessage();

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) =>
                        SelectRecipientsScreen(
                      emergencyType:
                          widget
                              .emergencyType,
                      selectedTags:
                          List.from(
                              selectedTags),
                      note:
                          noteController.text,
                      generatedMessage:
                          finalMessage,
                    ),
                  ),
                );
              },

              label: const Text(
                "Generate Message",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight:
                      FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
}