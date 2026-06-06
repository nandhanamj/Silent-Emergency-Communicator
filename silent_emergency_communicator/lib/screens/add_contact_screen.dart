import 'package:flutter/material.dart';

import '../models/emergency_contact.dart';

class AddContactScreen extends StatefulWidget {
  const AddContactScreen({super.key});

  @override
  State<AddContactScreen> createState() =>
      _AddContactScreenState();
}

class _AddContactScreenState
    extends State<AddContactScreen> {

  final _formKey = GlobalKey<FormState>();

  final nameController =
      TextEditingController();

  final phoneController =
      TextEditingController();

  String? selectedRelationship;

  final List<String> relationships = [
    'Parent',
    'Partner',
    'Sibling',
    'Friend',
    'Guardian',
    'Neighbour',
    'Other',
  ];

  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  void saveContact() {

    if (_formKey.currentState!.validate()) {

      if (selectedRelationship == null) {

        ScaffoldMessenger.of(context)
            .showSnackBar(
          const SnackBar(
            content: Text(
              'Please select a relationship',
            ),
          ),
        );

        return;
      }

      final contact = EmergencyContact(
        name: nameController.text.trim(),
        phoneNumber:
            phoneController.text.trim(),
        relationship:
            selectedRelationship!,
      );

      Navigator.pop(context, contact);
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Add Emergency Contact',
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),

        child: Form(
          key: _formKey,

          child: Column(
            children: [

              TextFormField(
                controller: nameController,

                decoration:
                    const InputDecoration(
                  labelText: 'Name',
                  border:
                      OutlineInputBorder(),
                ),

                validator: (value) {

                  if (value == null ||
                      value.trim().isEmpty) {

                    return 'Enter contact name';
                  }

                  return null;
                },
              ),

              const SizedBox(height: 16),

              TextFormField(
                controller: phoneController,
                keyboardType:
                    TextInputType.phone,

                decoration:
                    const InputDecoration(
                  labelText:
                      'Phone Number',
                  border:
                      OutlineInputBorder(),
                ),

                validator: (value) {

                  if (value == null ||
                      value.trim().isEmpty) {

                    return 'Enter phone number';
                  }

                  if (!RegExp(
                    r'^[6-9]\d{9}$',
                  ).hasMatch(value)) {

                    return 'Enter valid phone number';
                  }

                  return null;
                },
              ),

              const SizedBox(height: 16),

              DropdownButtonFormField<String>(
                value:
                    selectedRelationship,

                decoration:
                    const InputDecoration(
                  labelText:
                      'Relationship',
                  border:
                      OutlineInputBorder(),
                ),

                items: relationships
                    .map((relationship) {

                  return DropdownMenuItem(
                    value: relationship,
                    child:
                        Text(relationship),
                  );
                }).toList(),

                onChanged: (value) {

                  setState(() {
                    selectedRelationship =
                        value;
                  });
                },
              ),

              const SizedBox(height: 30),

              SizedBox(
                width: double.infinity,

                child: ElevatedButton(
                  onPressed: saveContact,

                  child: const Text(
                    'Save Contact',
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}