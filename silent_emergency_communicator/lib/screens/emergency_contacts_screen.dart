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

      appBar: AppBar(
        title: const Text(
          'Emergency Contacts',
        ),
      ),

      body: contacts.isEmpty
          ? const Center(
              child: Text(
                'No contacts added',
              ),
            )
          : ListView.builder(
              itemCount: contacts.length,
              itemBuilder: (context, index) {

                final contact =
                    contacts[index];

                return Card(
                  margin:
                      const EdgeInsets.all(8),

                  child: ListTile(
                    leading: const CircleAvatar(
                      child: Icon(Icons.person),
                    ),

                    title: Text(contact.name),

                    subtitle: Text(
                      '${contact.relationship}\n${contact.phoneNumber}',
                    ),

                    trailing: IconButton(
                      icon: const Icon(
                        Icons.delete,
                        color: Colors.red,
                      ),
                      onPressed: () {
                        deleteContact(index);
                      },
                    ),
                  ),
                );
              },
            ),

      floatingActionButton:
          FloatingActionButton(
        onPressed: addContact,
        child: const Icon(Icons.add),
      ),
    );
  }
}