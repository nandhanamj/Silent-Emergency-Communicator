import 'package:flutter/material.dart';

import '../models/emergency_contact.dart';
import '../services/contact_storage_service.dart';
import 'review_alert_screen.dart';

class SelectRecipientsScreen extends StatefulWidget {
  final String emergencyType;
  final List selectedTags;
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

  @override
  void initState() {
    super.initState();

    loadContacts();
  }

  Future<void> loadContacts() async {
    final data =
        await ContactStorageService.getContacts();

    setState(() {
      contacts = data;
    });
  }

  void continueToReview() {
    if (selectedContacts.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "Please select at least one recipient",
          ),
        ),
      );
      return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ReviewAlertScreen(
          emergencyType: widget.emergencyType,
          selectedTags:
              List.from(widget.selectedTags),
          note: widget.note,
          generatedMessage:
              widget.generatedMessage,
          selectedContacts:
              selectedContacts,
          policeSelected: false,
fireSelected: false,
ambulanceSelected: false,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          const Color(0xFFF8F9FC),

      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        title: const Text(
          "Select Recipients",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: ListView(
        padding:
            const EdgeInsets.all(16),

        children: [

          /// HEADER

          Container(
            padding:
                const EdgeInsets.all(20),

            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius:
                  BorderRadius.circular(
                      24),
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
                    Icons.group,
                    size: 40,
                    color:
                        Colors.red.shade700,
                  ),
                ),

                const SizedBox(
                    height: 15),

                const Text(
                  "Choose Recipients",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight:
                        FontWeight.bold,
                  ),
                ),

                const SizedBox(
                    height: 8),

                Text(
                  "Select emergency contacts who should receive this alert.",
                  textAlign:
                      TextAlign.center,
                  style: TextStyle(
                    color: Colors
                        .grey.shade600,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          /// CONTACTS CARD

          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius:
                  BorderRadius.circular(
                      24),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 8,
                  offset: Offset(0, 4),
                ),
              ],
            ),

            child: Padding(
              padding:
                  const EdgeInsets.all(
                      16),

              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment
                        .start,
                children: [

                  const Text(
                    "Emergency Contacts",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight:
                          FontWeight.bold,
                    ),
                  ),

                  const SizedBox(
                      height: 12),

                  if (contacts.isEmpty)
                    Container(
                      width:
                          double.infinity,
                      padding:
                          const EdgeInsets
                              .all(16),

                      decoration:
                          BoxDecoration(
                        color: Colors
                            .grey.shade100,
                        borderRadius:
                            BorderRadius
                                .circular(
                                    12),
                      ),

                      child: const Text(
                        "No emergency contacts added yet.",
                      ),
                    )
                  else
                    ...contacts.map(
                      (contact) => Material(
    color: Colors.transparent,
    child: CheckboxListTile(
      value: selectedContacts.contains(contact),

      activeColor: Colors.red.shade700,

      title: Text(contact.name),

      subtitle: Text(
        contact.relationship,
      ),

      onChanged: (value) {
        setState(() {
          if (value == true) {
            selectedContacts.add(contact);
          } else {
            selectedContacts.remove(contact);
          }
        });
      },
    ),
  ),
),
                ],
              ),
            ),
          ),

          const SizedBox(height: 20),

         /// AUTHORITIES CARD

Container(
  decoration: BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(24),
    boxShadow: const [
      BoxShadow(
        color: Colors.black12,
        blurRadius: 8,
        offset: Offset(0, 4),
      ),
    ],
  ),
  child: Padding(
    padding: const EdgeInsets.all(16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        const Text(
          "Authorities",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),

        const SizedBox(height: 12),

        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.orange.shade50,
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Text(
            "Direct authority communication is planned for a future update.",
          ),
        ),

        const SizedBox(height: 15),

        const Material(
  color: Colors.transparent,
  child: ListTile(
    leading: Icon(Icons.local_police),
    title: Text("Police Integration"),
    subtitle: Text("Coming Soon"),
  ),
),

        const Material(
  color: Colors.transparent,
  child: ListTile(
    leading: Icon(Icons.local_fire_department),
    title: Text("Fire Department Integration"),
    subtitle: Text("Coming Soon"),
  ),
),

        const Material(
  color: Colors.transparent,
  child: ListTile(
    leading: Icon(Icons.medical_services),
    title: Text("Ambulance Integration"),
    subtitle: Text("Coming Soon"),
  ),
),
      ],
    ),
  ),
),

          const SizedBox(height: 25),

          SizedBox(
            height: 55,
            child: ElevatedButton(
              style:
                  ElevatedButton.styleFrom(
                backgroundColor:
                    Colors.red.shade700,
                foregroundColor:
                    Colors.white,
                shape:
                    RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius
                          .circular(16),
                ),
              ),

              onPressed:
                  continueToReview,

              child: const Text(
                "Continue",
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
    );
  }
}
