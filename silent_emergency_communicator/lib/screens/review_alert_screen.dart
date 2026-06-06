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
Card(
  child: Padding(
    padding: const EdgeInsets.all(16),
    child: Column(
      crossAxisAlignment:
          CrossAxisAlignment.start,
      children: [

        const Text(
          "Current Location",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),

        const SizedBox(height: 10),
       if (mapsLink.isNotEmpty) ...[
  Text("Latitude: $latitude"),
  Text("Longitude: $longitude"),

  const SizedBox(height: 8),

  Text(
    mapsLink,
    style: const TextStyle(
      color: Colors.blue,
    ),
  ),
] else ...[
  const Text(
    "GPS Location Unavailable",
    style: TextStyle(
      color: Colors.red,
      fontWeight: FontWeight.bold,
    ),
  ),

  const SizedBox(height: 5),

  const Text(
    "Emergency alert will still be sent.",
  ),
],
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
Card(
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
            fontWeight: FontWeight.bold,
          ),
        ),

        const SizedBox(height: 12),

        if (contacts.isNotEmpty) ...[

          Text(
            "Emergency Contacts (${contacts.length})",
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 8),

          ...widget.selectedContacts.map(
  (contact) => ListTile(
    leading:
        const Icon(Icons.person),
    title: Text(contact.name),
    subtitle:
        Text(contact.phoneNumber),
  ),
),
if (widget.policeSelected)
  const ListTile(
    leading:
        Icon(Icons.local_police),
    title: Text("Police"),
  ),

if (widget.fireSelected)
  const ListTile(
    leading: Icon(
      Icons.local_fire_department,
    ),
    title:
        Text("Fire Department"),
  ),

if (widget.ambulanceSelected)
  const ListTile(
    leading: Icon(
      Icons.medical_services,
    ),
    title: Text("Ambulance"),
  ),

        ] else ...

          [
            const Text(
              "No emergency contacts added",
            ),
          ],

        const Divider(),

        const ListTile(
          leading: Icon(
            Icons.local_fire_department,
            color: Colors.orange,
          ),
          title: Text(
            "Fire Department",
          ),
          subtitle: Text(
            "Coming Soon",
          ),
        ),

        const ListTile(
          leading: Icon(
            Icons.local_police,
            color: Colors.blue,
          ),
          title: Text(
            "Police Department",
          ),
          subtitle: Text(
            "Coming Soon",
          ),
        ),

        const ListTile(
          leading: Icon(
            Icons.medical_services,
            color: Colors.red,
          ),
          title: Text(
            "Ambulance Service",
          ),
          subtitle: Text(
            "Coming Soon",
          ),
        ),
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
                onPressed: sendAlert,
              ),
            ),
          ],
        ),
      ),
    );
  }
}