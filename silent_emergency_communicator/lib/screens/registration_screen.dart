import 'package:flutter/material.dart';
import '../services/storage_service.dart';
class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController medicalController = TextEditingController();
  final TextEditingController infoController = TextEditingController();

  String? selectedBloodGroup;
  @override
  void initState() {
  super.initState();
  loadProfile();
 }

 Future<void> loadProfile() async {
  final profile = await StorageService.getUserProfile();

  setState(() {
    nameController.text = profile['fullName'] ?? '';
    phoneController.text = profile['phoneNumber'] ?? '';
    medicalController.text = profile['medicalNotes'] ?? '';
    infoController.text = profile['additionalInfo'] ?? '';

    if ((profile['bloodGroup'] ?? '').isNotEmpty) {
      selectedBloodGroup = profile['bloodGroup'];
    }
  });
}

  final List<String> bloodGroups = [
    'A+',
    'A-',
    'B+',
    'B-',
    'AB+',
    'AB-',
    'O+',
    'O-',
  ];

  bool isValidIndianPhone(String phone) {
    return RegExp(r'^[6-9]\d{9}$').hasMatch(phone);
  }

  Future<void> validateAndContinue() async {
  if (_formKey.currentState!.validate()) {
    if (selectedBloodGroup == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select a blood group'),
        ),
      );
      return;
    }

    await StorageService.saveUserProfile(
      fullName: nameController.text.trim(),
      phoneNumber: phoneController.text.trim(),
      bloodGroup: selectedBloodGroup!,
      medicalNotes: medicalController.text.trim(),
      additionalInfo: infoController.text.trim(),
    );

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Profile saved successfully'),
      ),
    );
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),

      appBar: AppBar(
        backgroundColor: Colors.red,
        foregroundColor: Colors.white,
        title: const Text(
          'Registration',
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),

        child: Form(
          key: _formKey,

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,

            children: [

              const Icon(
                Icons.health_and_safety,
                color: Colors.red,
                size: 80,
              ),

              const SizedBox(height: 15),

              const Text(
                'Silent Emergency Communicator',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),

              const SizedBox(height: 8),

              const Text(
                'Create Your Emergency Profile',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black54,
                ),
              ),

              const SizedBox(height: 30),

              TextFormField(
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: 'Full Name *',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter your name';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 20),

              TextFormField(
                controller: phoneController,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                  labelText: 'Phone Number *',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter phone number';
                  }

                  if (!isValidIndianPhone(value)) {
                    return 'Enter a valid Indian mobile number';
                  }

                  return null;
                },
              ),

              const SizedBox(height: 20),

              DropdownButtonFormField<String>(
                value: selectedBloodGroup,
                decoration: const InputDecoration(
                  labelText: 'Blood Group *',
                  border: OutlineInputBorder(),
                ),
                items: bloodGroups.map((group) {
                  return DropdownMenuItem(
                    value: group,
                    child: Text(group),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    selectedBloodGroup = value;
                  });
                },
              ),

              const SizedBox(height: 20),

              TextFormField(
                controller: medicalController,
                maxLines: 3,
                decoration: const InputDecoration(
                  labelText: 'Medical Notes (Optional)',
                  border: OutlineInputBorder(),
                ),
              ),

              const SizedBox(height: 20),

              TextFormField(
                controller: infoController,
                maxLines: 3,
                decoration: const InputDecoration(
                  labelText: 'Additional Information (Optional)',
                  border: OutlineInputBorder(),
                ),
              ),

              const SizedBox(height: 30),

              SizedBox(
                height: 55,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                  ),
                  onPressed: validateAndContinue,
                  child: const Text(
                    'Continue',
                    style: TextStyle(fontSize: 18),
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