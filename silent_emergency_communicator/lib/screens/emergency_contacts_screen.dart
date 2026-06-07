import 'package:flutter/material.dart';

import '../models/emergency_contact.dart';
import '../services/contact_storage_service.dart';
import 'add_contact_screen.dart';

class EmergencyContactsScreen extends StatefulWidget {
  const EmergencyContactsScreen({super.key});

  @override
  State<EmergencyContactsScreen> createState() =>
      _EmergencyContactsScreenState();
}

class _EmergencyContactsScreenState
    extends State<EmergencyContactsScreen> {

  List<EmergencyContact> contacts = [];

  @override
  void initState() {
    super.initState();
    loadContacts();
  }

  Future<void> loadContacts() async {
    contacts =
        await ContactStorageService.getContacts();

    setState(() {});
  }

  Future<void> addContact() async {

    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const AddContactScreen(),
      ),
    );

    if (result != null &&
        result is EmergencyContact) {

      contacts.add(result);

      await ContactStorageService.saveContacts(
        contacts,
      );

      setState(() {});
    }
  }

  Future<void> deleteContact(int index) async {

    contacts.removeAt(index);

    await ContactStorageService.saveContacts(
      contacts,
    );

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
  backgroundColor: const Color(0xFFF8F9FC),

      appBar: AppBar(
  title: const Text(
    "Emergency Contacts",
  ),
  elevation: 0,
  backgroundColor: Colors.white,
  foregroundColor: Colors.black,
),

body: Column(
  children: [

    // Emergency Authorities Card

    Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 8,
            offset: Offset(0, 3),
          ),
        ],
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Row(
            children: const [
              Icon(
                Icons.local_police,
                color: Colors.red,
              ),
              SizedBox(width: 8),
              Text(
                "Emergency Authorities",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),

          SizedBox(height: 12),

          const SizedBox(height: 10),

Row(
  children: const [
    Icon(Icons.local_police),
    SizedBox(width: 12),
    Text(
      "Police - 100",
      style: TextStyle(fontSize: 16),
    ),
  ],
),

SizedBox(height: 12),

Row(
  children: const [
    Icon(Icons.local_fire_department),
    SizedBox(width: 12),
    Text(
      "Fire Force - 101",
      style: TextStyle(fontSize: 16),
    ),
  ],
),

SizedBox(height: 12),

Row(
  children: const [
    Icon(Icons.medical_services),
    SizedBox(width: 12),
    Text(
      "Ambulance - 108",
      style: TextStyle(fontSize: 16),
    ),
  ],
),

          Center(
            child: Chip(
              label: Text("Coming Soon"),
            ),
          ),
        ],
      ),
    ),

    // Existing Contacts Section

    Expanded(
      child: contacts.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment:
                    MainAxisAlignment.center,
                children: [
                  // your existing empty state
                ],
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
              ),
              itemCount: contacts.length,
             itemBuilder: (context, index) {
  final contact = contacts[index];

  return Container(
    margin: const EdgeInsets.only(
      bottom: 15,
    ),
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(20),
      boxShadow: const [
        BoxShadow(
          color: Colors.black12,
          blurRadius: 8,
          offset: Offset(0, 3),
        ),
      ],
    ),
    child: Row(
      children: [

        CircleAvatar(
          radius: 28,
          backgroundColor: Colors.red.shade50,
          child: Icon(
            Icons.person,
            color: Colors.red.shade700,
          ),
        ),

        const SizedBox(width: 15),

        Expanded(
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,
            children: [

              Text(
                contact.name,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight:
                      FontWeight.bold,
                ),
              ),

              const SizedBox(height: 4),

              Text(
                contact.relationship,
                style: const TextStyle(
                  color: Colors.grey,
                ),
              ),

              const SizedBox(height: 4),

              Text(
                contact.phoneNumber,
                style: const TextStyle(
                  fontWeight:
                      FontWeight.w600,
                ),
              ),
            ],
          ),
        ),

        IconButton(
          icon: const Icon(
            Icons.delete_outline,
            color: Colors.red,
          ),
          onPressed: () {
            deleteContact(index);
          },
        ),
      ],
    ),
  );
},
            ),
    ),
  ],
),
floatingActionButton:
    FloatingActionButton.extended(
  onPressed: addContact,
  backgroundColor:
      Colors.red.shade700,
  icon: const Icon(
    Icons.add,
    color: Colors.white,
  ),
  label: const Text(
    "Add Contact",
    style: TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.bold,
    ),
  ),
),
    );
  }
}