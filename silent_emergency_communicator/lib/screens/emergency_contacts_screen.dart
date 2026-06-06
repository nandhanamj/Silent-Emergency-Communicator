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

      body: contacts.isEmpty
    ? Center(
        child: Column(
          mainAxisAlignment:
              MainAxisAlignment.center,
          children: [

            Icon(
              Icons.contacts,
              size: 80,
              color: Colors.grey.shade400,
            ),

            const SizedBox(height: 15),

            const Text(
              "No Emergency Contacts",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 5),

            const Text(
              "Add trusted contacts for emergencies",
              style: TextStyle(
                color: Colors.grey,
              ),
            ),
          ],
        ),
      )
    : ListView.builder(
        padding:
            const EdgeInsets.all(16),
        itemCount: contacts.length,
        itemBuilder:
            (context, index) {

          final contact =
              contacts[index];

          return Container(
            margin:
                const EdgeInsets.only(
              bottom: 15,
            ),
            padding:
                const EdgeInsets.all(
              16,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius:
                  BorderRadius.circular(
                20,
              ),
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
                  backgroundColor:
                      Colors.red.shade50,
                  child: Icon(
                    Icons.person,
                    color:
                        Colors.red.shade700,
                  ),
                ),

                const SizedBox(
                  width: 15,
                ),

                Expanded(
                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment
                            .start,
                    children: [

                      Text(
                        contact.name,
                        style:
                            const TextStyle(
                          fontSize: 18,
                          fontWeight:
                              FontWeight.bold,
                        ),
                      ),

                      const SizedBox(
                        height: 4,
                      ),

                      Text(
                        contact.relationship,
                        style:
                            const TextStyle(
                          color:
                              Colors.grey,
                        ),
                      ),

                      const SizedBox(
                        height: 4,
                      ),

                      Text(
                        contact.phoneNumber,
                        style:
                            const TextStyle(
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
                    deleteContact(
                      index,
                    );
                  },
                ),
              ],
            ),
          );
        },
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