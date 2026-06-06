import 'package:flutter/material.dart';
import 'package:vibration/vibration.dart';
import '../services/storage_service.dart';
import '../services/location_service.dart';
import '../services/contact_storage_service.dart';
import '../services/sms_service.dart';
import '../models/emergency_contact.dart';
import '../models/emergency_history.dart';
import '../services/history_storage_service.dart';
import '../services/network_service.dart';
class ReviewAlertScreen extends StatefulWidget {
  final String emergencyType;
  final List<String> selectedTags;
  final String note;
  final String generatedMessage;
  final List<EmergencyContact> selectedContacts;

final bool policeSelected;
final bool fireSelected;
final bool ambulanceSelected;

  const ReviewAlertScreen({
  super.key,
  required this.emergencyType,
  required this.selectedTags,
  required this.note,
  required this.generatedMessage,
  required this.selectedContacts,
  required this.policeSelected,
  required this.fireSelected,
  required this.ambulanceSelected,
});

  @override
  State<ReviewAlertScreen> createState() =>
      _ReviewAlertScreenState();
}
class _ReviewAlertScreenState
    extends State<ReviewAlertScreen> {

  Map<String, dynamic> profile = {};
  List<EmergencyContact> contacts = [];
  String latitude = '';
String longitude = '';
String mapsLink = '';

  @override
void initState() {
  super.initState();
  loadProfile();
  loadLocation();
}

  Future loadProfile() async {

  final data =
      await StorageService.getUserProfile();

  final savedContacts =
      await ContactStorageService.getContacts();

  setState(() {
    profile = data;
    contacts = savedContacts;
  });
}
Future<void> sendAlert() async {
  final contacts = widget.selectedContacts;

  if (contacts.isEmpty) {
    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'No emergency contacts selected',
        ),
      ),
    );

    return;
  }

  final phoneNumbers = contacts
      .map((contact) => contact.phoneNumber)
      .join(',');

  final finalMessage = buildFinalMessage();

  // Vibration feedback
  if (await Vibration.hasVibrator() ?? false) {
    Vibration.vibrate(
      duration: 500,
    );
  }

  // Check internet (optional)
  final hasInternet =
      await NetworkService.isInternetAvailable();

  if (hasInternet) {
    print("Internet Available");

    // Future Firebase Sync Here

  } else {
    print("No Internet");
  }

  // ALWAYS launch SMS
  await SmsService.sendSms(
    phoneNumbers,
    finalMessage,
  );

  // Save to history
  final history = EmergencyHistory(
    emergencyType: widget.emergencyType,
    dateTime: DateTime.now().toString(),
    message: finalMessage,
    recipients: contacts
        .map((e) => e.phoneNumber)
        .toList(),
  );

  await HistoryStorageService.saveHistory(
    history,
  );

  if (!mounted) return;

  ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(
      content: Text(
        "Emergency Alert Saved",
      ),
    ),
  );
}

Future<void> loadLocation() async {
  try {
    final position =
        await LocationService.getCurrentLocation();

    if (position == null) {
      setState(() {
        latitude = "Unavailable";
        longitude = "Unavailable";
        mapsLink = "";
      });

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              "Location unavailable. Alert will be sent without GPS.",
            ),
          ),
        );
      }

      return;
    }

    setState(() {
      latitude = position.latitude.toString();
      longitude = position.longitude.toString();

      mapsLink =
          "https://maps.google.com/?q=$latitude,$longitude";
    });
  } catch (e) {
    setState(() {
      latitude = "Unavailable";
      longitude = "Unavailable";
      mapsLink = "";
    });

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "Failed to fetch location.",
          ),
        ),
      );
    }
  }
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
if (mapsLink.isNotEmpty) {
  message +=
      "\n\nLocation:\n$mapsLink";
} else {
  message +=
      "\n\nLocation: Unavailable";
}
  message +=
      "\n\nPlease respond immediately.";

  return message;
}

@override
Widget build(BuildContext context) {
  Color emergencyColor = Colors.red;

  switch (widget.emergencyType) {
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
      emergencyColor = Colors.red;
  }

  return Scaffold(
    backgroundColor: const Color(0xFFF8F9FC),

    appBar: AppBar(
      elevation: 0,
      backgroundColor: Colors.white,
      foregroundColor: Colors.black,
      title: const Text(
        "Review Alert",
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
    ),

    body: SingleChildScrollView(
      padding: const EdgeInsets.all(16),

      child: Column(
        children: [

          /// HEADER

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
                  radius: 45,
                  backgroundColor:
                      emergencyColor.withOpacity(0.15),

                  child: Icon(
                    Icons.warning_amber_rounded,
                    size: 45,
                    color: emergencyColor,
                  ),
                ),

                const SizedBox(height: 15),

                Text(
                  "${widget.emergencyType} Alert",
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 8),

                Text(
                  "Review all details before sending the emergency alert.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.grey.shade600,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          /// USER PROFILE

          Card(
            shape: RoundedRectangleBorder(
              borderRadius:
                  BorderRadius.circular(20),
            ),

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
                      fontWeight:
                          FontWeight.bold,
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

          const SizedBox(height: 15),

          /// LOCATION

          Card(
            shape: RoundedRectangleBorder(
              borderRadius:
                  BorderRadius.circular(20),
            ),

            child: ListTile(
              leading: Icon(
                Icons.location_on,
                color: emergencyColor,
              ),

              title: const Text(
                "Current Location",
              ),

              subtitle: Text(
                mapsLink.isNotEmpty
                    ? mapsLink
                    : "Location unavailable",
              ),
            ),
          ),

          const SizedBox(height: 15),

          /// TAGS

          Card(
            shape: RoundedRectangleBorder(
              borderRadius:
                  BorderRadius.circular(20),
            ),

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
                      fontWeight:
                          FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 12),

                  Wrap(
                    spacing: 8,
                    runSpacing: 8,

                    children: widget.selectedTags
                        .map(
                          (tag) => Chip(
                            label: Text(tag),
                          ),
                        )
                        .toList(),
                  ),
                ],
              ),
            ),
          ),

          if (widget.note.isNotEmpty) ...[

            const SizedBox(height: 15),

            Card(
              shape: RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.circular(20),
              ),

              child: ListTile(
                leading:
                    const Icon(Icons.notes),

                title:
                    const Text("Additional Note"),

                subtitle: Text(widget.note),
              ),
            ),
          ],

          const SizedBox(height: 15),

          /// RECIPIENTS

          Card(
            shape: RoundedRectangleBorder(
              borderRadius:
                  BorderRadius.circular(20),
            ),

            child: Padding(
              padding: const EdgeInsets.all(16),

              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,

                children: [

                  const Text(
                    "Recipients",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight:
                          FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 12),

                  ...widget.selectedContacts.map(
                    (contact) => ListTile(
                      leading:
                          const Icon(Icons.person),
                      title: Text(contact.name),
                      subtitle:
                          Text(contact.phoneNumber),
                    ),
                  ),

                  Wrap(
                    spacing: 8,

                    children: [

                      if (widget.policeSelected)
                        const Chip(
                          label: Text("Police"),
                        ),

                      if (widget.fireSelected)
                        const Chip(
                          label: Text("Fire"),
                        ),

                      if (widget.ambulanceSelected)
                        const Chip(
                          label: Text("Ambulance"),
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 15),

          /// MESSAGE PREVIEW

          Card(
            shape: RoundedRectangleBorder(
              borderRadius:
                  BorderRadius.circular(20),
            ),

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
                      fontWeight:
                          FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 12),

                  Container(
                    constraints:
                        const BoxConstraints(
                      maxHeight: 250,
                    ),

                    child: SingleChildScrollView(
                      child: SelectableText(
                        buildFinalMessage(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 25),

          SizedBox(
            width: double.infinity,
            height: 60,

            child: ElevatedButton.icon(
              icon: const Icon(Icons.send),

              style:
                  ElevatedButton.styleFrom(
                backgroundColor:
                    emergencyColor,

                foregroundColor:
                    Colors.white,

                shape:
                    RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(16),
                ),
              ),

              onPressed: sendAlert,

              label: const Text(
                "SEND EMERGENCY ALERT",
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