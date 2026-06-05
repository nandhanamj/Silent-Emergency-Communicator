import 'package:flutter/material.dart';

import '../models/emergency_contact.dart';
import '../services/contact_storage_service.dart';
import 'review_alert_screen.dart';

class SelectRecipientsScreen extends StatefulWidget {
  final String emergencyType;
  final List<String> selectedTags;
  final String note;
  final String generatedMessage;

  const SelectRecipientsScreen({
    super.key,
    required this.emergencyType,
    required this.selectedTags,
    required this.note,
    required this.generatedMessage,
  });

  @override
  State<SelectRecipientsScreen> createState() =>
      _SelectRecipientsScreenState();
}

class _SelectRecipientsScreenState
    extends State<SelectRecipientsScreen> {

  List<EmergencyContact> contacts = [];

  List<EmergencyContact> selectedContacts = [];

  bool policeSelected = false;
  bool fireSelected = false;
  bool ambulanceSelected = false;

  @override
  void initState() {
    super.initState();
    loadContacts();
  }

  Future loadContacts() async {
    final data =
        await ContactStorageService.getContacts();

    setState(() {
      contacts = data;
    });
  }

  void continueToReview() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ReviewAlertScreen(
          emergencyType: widget.emergencyType,
          selectedTags: List<String>.from(widget.selectedTags),
          note: widget.note,
          generatedMessage:
              widget.generatedMessage,
          selectedContacts:
              selectedContacts,
          policeSelected:
              policeSelected,
          fireSelected:
              fireSelected,
          ambulanceSelected:
              ambulanceSelected,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            const Text("Select Recipients"),
      ),
      body: ListView(
        padding:
            const EdgeInsets.all(16),
        children: [

          const Text(
            "Emergency Contacts",
            style: TextStyle(
              fontSize: 18,
              fontWeight:
                  FontWeight.bold,
            ),
          ),

          const SizedBox(height: 10),

          ...contacts.map(
            (contact) =>
                CheckboxListTile(
              title: Text(contact.name),
              subtitle: Text(
                contact.relationship,
              ),
              value:
                  selectedContacts.contains(
                      contact),
              onChanged: (value) {
                setState(() {
                  if (value == true) {
                    selectedContacts
                        .add(contact);
                  } else {
                    selectedContacts
                        .remove(contact);
                  }
                });
              },
            ),
          ),

          const Divider(),

          const Text(
            "Authorities",
            style: TextStyle(
              fontSize: 18,
              fontWeight:
                  FontWeight.bold,
            ),
          ),

          CheckboxListTile(
            title:
                const Text("Police"),
            value: policeSelected,
            onChanged: (value) {
              setState(() {
                policeSelected =
                    value!;
              });
            },
          ),

          CheckboxListTile(
            title: const Text(
                "Fire Department"),
            value: fireSelected,
            onChanged: (value) {
              setState(() {
                fireSelected =
                    value!;
              });
            },
          ),

          CheckboxListTile(
            title:
                const Text("Ambulance"),
            value:
                ambulanceSelected,
            onChanged: (value) {
              setState(() {
                ambulanceSelected =
                    value!;
              });
            },
          ),

          const SizedBox(height: 20),

          ElevatedButton(
            onPressed:
                continueToReview,
            child:
                const Text("Continue"),
          ),
        ],
      ),
    );
  }
}