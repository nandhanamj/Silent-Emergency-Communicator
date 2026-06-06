import 'package:flutter/material.dart';

import '../services/storage_service.dart';

class EditProfileScreen extends StatefulWidget {
  final Map<String, dynamic> profile;

  const EditProfileScreen({
    super.key,
    required this.profile,
  });

  @override
  State<EditProfileScreen> createState() =>
      _EditProfileScreenState();
}

class _EditProfileScreenState
    extends State<EditProfileScreen> {

  final _formKey = GlobalKey<FormState>();

  late TextEditingController nameController;
  late TextEditingController phoneController;
  late TextEditingController bloodController;

  @override
  void initState() {
    super.initState();

    nameController =
        TextEditingController(
      text: widget.profile['fullName'] ?? '',
    );

    phoneController =
        TextEditingController(
      text: widget.profile['phoneNumber'] ?? '',
    );

    bloodController =
        TextEditingController(
      text: widget.profile['bloodGroup'] ?? '',
    );
  }

  Future<void> saveProfile() async {

  await StorageService.saveUserProfile(
    fullName: nameController.text.trim(),

    phoneNumber:
        phoneController.text.trim(),

    bloodGroup:
        bloodController.text.trim(),

    medicalNotes:
        widget.profile['medicalNotes'] ?? '',

    additionalInfo:
        widget.profile['additionalInfo'] ?? '',
  );

  if (!mounted) return;

  Navigator.pop(context, true);
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Edit Profile",
        ),
      ),
      body: Padding(
        padding:
            const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [

              TextFormField(
                controller:
                    nameController,
                decoration:
                    const InputDecoration(
                  labelText:
                      "Full Name",
                ),
              ),

              const SizedBox(
                height: 16,
              ),

              TextFormField(
                controller:
                    phoneController,
                decoration:
                    const InputDecoration(
                  labelText:
                      "Phone Number",
                ),
              ),

              const SizedBox(
                height: 16,
              ),

              TextFormField(
                controller:
                    bloodController,
                decoration:
                    const InputDecoration(
                  labelText:
                      "Blood Group",
                ),
              ),

              const SizedBox(
                height: 30,
              ),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed:
                      saveProfile,
                  child: const Text(
                    "Save Changes",
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