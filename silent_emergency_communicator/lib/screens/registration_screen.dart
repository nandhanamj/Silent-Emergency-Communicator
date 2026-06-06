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
    backgroundColor: const Color(0xFFF8F9FC),

    appBar: AppBar(
      elevation: 0,
      backgroundColor: Colors.white,
      foregroundColor: Colors.black,
      title: const Text(
        "Registration",
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
    ),

    body: SingleChildScrollView(
      padding: const EdgeInsets.all(16),

      child: Form(
        key: _formKey,

        child: Column(
          children: [

            // HEADER CARD

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),

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

              child: Column(
                children: [

                  CircleAvatar(
                    radius: 45,
                    backgroundColor:
                        Colors.red.shade50,

                    child: Icon(
                      Icons.health_and_safety,
                      size: 50,
                      color: Colors.red.shade700,
                    ),
                  ),

                  const SizedBox(height: 16),

                  const Text(
                    "Emergency Profile",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight:
                          FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 8),

                  Text(
                    "Create your emergency information profile for quick assistance.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color:
                          Colors.grey.shade600,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // FORM CARD

            Container(
              padding: const EdgeInsets.all(20),

              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius:
                    BorderRadius.circular(24),

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

                  TextFormField(
                    controller: nameController,

                    decoration:
                        InputDecoration(
                      labelText:
                          "Full Name",
                      prefixIcon:
                          const Icon(
                        Icons.person,
                      ),
                      border:
                          OutlineInputBorder(
                        borderRadius:
                            BorderRadius.circular(
                                15),
                      ),
                    ),

                    validator: (value) {
                      if (value == null ||
                          value.trim()
                              .isEmpty) {
                        return "Please enter your name";
                      }
                      return null;
                    },
                  ),

                  const SizedBox(height: 16),

                  TextFormField(
                    controller:
                        phoneController,
                    keyboardType:
                        TextInputType.phone,

                    decoration:
                        InputDecoration(
                      labelText:
                          "Phone Number",
                      prefixIcon:
                          const Icon(
                        Icons.phone,
                      ),
                      border:
                          OutlineInputBorder(
                        borderRadius:
                            BorderRadius.circular(
                                15),
                      ),
                    ),

                    validator: (value) {
                      if (value == null ||
                          value.isEmpty) {
                        return "Please enter phone number";
                      }

                      if (!isValidIndianPhone(
                          value)) {
                        return "Enter a valid Indian mobile number";
                      }

                      return null;
                    },
                  ),

                  const SizedBox(height: 16),

                  DropdownButtonFormField<
                      String>(
                    value:
                        selectedBloodGroup,

                    decoration:
                        InputDecoration(
                      labelText:
                          "Blood Group",
                      prefixIcon:
                          const Icon(
                        Icons.bloodtype,
                      ),
                      border:
                          OutlineInputBorder(
                        borderRadius:
                            BorderRadius.circular(
                                15),
                      ),
                    ),

                    items: bloodGroups
                        .map((group) {
                      return DropdownMenuItem(
                        value: group,
                        child:
                            Text(group),
                      );
                    }).toList(),

                    onChanged: (value) {
                      setState(() {
                        selectedBloodGroup =
                            value;
                      });
                    },
                  ),

                  const SizedBox(height: 16),

                  TextFormField(
                    controller:
                        medicalController,
                    maxLines: 3,

                    decoration:
                        InputDecoration(
                      labelText:
                          "Medical Notes",
                      prefixIcon:
                          const Icon(
                        Icons.medical_services,
                      ),
                      border:
                          OutlineInputBorder(
                        borderRadius:
                            BorderRadius.circular(
                                15),
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  TextFormField(
                    controller:
                        infoController,
                    maxLines: 3,

                    decoration:
                        InputDecoration(
                      labelText:
                          "Additional Information",
                      prefixIcon:
                          const Icon(
                        Icons.info,
                      ),
                      border:
                          OutlineInputBorder(
                        borderRadius:
                            BorderRadius.circular(
                                15),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 25),

            SizedBox(
              width: double.infinity,
              height: 55,

              child: ElevatedButton.icon(
                icon: const Icon(
                  Icons.save,
                ),

                style:
                    ElevatedButton.styleFrom(
                  backgroundColor:
                      Colors.red.shade700,

                  foregroundColor:
                      Colors.white,

                  shape:
                      RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(
                            16),
                  ),
                ),

                onPressed:
                    validateAndContinue,

                label: const Text(
                  "Save Profile",
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
      ),
    ),
  );
}
}