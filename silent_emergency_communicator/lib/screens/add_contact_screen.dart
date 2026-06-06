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
  backgroundColor: const Color(0xFFF8F9FC),
      appBar: AppBar(
  title: const Text(
    "Add Emergency Contact",
  ),
  elevation: 0,
  backgroundColor: Colors.white,
  foregroundColor: Colors.black,
),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),

        child: Container(
  padding: const EdgeInsets.all(20),
  decoration: BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(24),
    boxShadow: const [
      BoxShadow(
        color: Colors.black12,
        blurRadius: 10,
        offset: Offset(0, 4),
      ),
    ],
  ),
  child: Form(
          key: _formKey,

          child: Column(
            children: [

              TextFormField(
                controller: nameController,

                decoration: InputDecoration(
  labelText: "Full Name",
  prefixIcon: const Icon(
    Icons.person_outline,
  ),
  border: OutlineInputBorder(
    borderRadius:
        BorderRadius.circular(16),
  ),
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

                decoration: InputDecoration(
  labelText: "Phone Number",
  prefixIcon: const Icon(
    Icons.phone_outlined,
  ),
  border: OutlineInputBorder(
    borderRadius:
        BorderRadius.circular(16),
  ),
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

                decoration: InputDecoration(
  labelText: "Relationship",
  prefixIcon: const Icon(
    Icons.people_outline,
  ),
  border: OutlineInputBorder(
    borderRadius:
        BorderRadius.circular(16),
  ),
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
  height: 55,
  child: ElevatedButton.icon(
                  onPressed: saveContact,

style: ElevatedButton.styleFrom(
  backgroundColor:
      Colors.red.shade700,
  shape: RoundedRectangleBorder(
    borderRadius:
        BorderRadius.circular(16),
  ),
),

icon: const Icon(
  Icons.save,
  color: Colors.white,
),

label: const Text(
  "Save Contact",
  style: TextStyle(
    color: Colors.white,
    fontSize: 16,
    fontWeight: FontWeight.bold,
  ),
),
                ),
              ),
            ],
          ),
        ),
      ),
      ),
    );
  }
}