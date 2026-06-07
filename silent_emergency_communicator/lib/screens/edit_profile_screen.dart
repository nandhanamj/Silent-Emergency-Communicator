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

  final _formKey =
      GlobalKey<FormState>();

  late TextEditingController nameController;
  late TextEditingController phoneController;
  late TextEditingController bloodController;
  late TextEditingController medicalController;
late TextEditingController additionalController;

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
    medicalController =
    TextEditingController(
  text: widget.profile['medicalNotes'] ?? '',
);

additionalController =
    TextEditingController(
  text: widget.profile['additionalInfo'] ?? '',
);
  }

  Future<void> saveProfile() async {
    await StorageService.saveUserProfile(
      fullName:
          nameController.text.trim(),
      phoneNumber:
          phoneController.text.trim(),
      bloodGroup:
          bloodController.text.trim(),
      medicalNotes:
    medicalController.text.trim(),

additionalInfo:
    additionalController.text.trim(),
    );

    if (!mounted) return;

    Navigator.pop(context, true);
  }

  Widget buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
  }) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        prefixIcon: Icon(
          icon,
          color: Colors.red.shade700,
        ),
        labelText: label,

        filled: true,
        fillColor: Colors.grey.shade50,

        border: OutlineInputBorder(
          borderRadius:
              BorderRadius.circular(16),
        ),

        enabledBorder:
            OutlineInputBorder(
          borderRadius:
              BorderRadius.circular(16),
          borderSide: BorderSide(
            color: Colors.grey.shade300,
          ),
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
          "Edit Profile",
          style: TextStyle(
            fontWeight:
                FontWeight.bold,
          ),
        ),
      ),

      body: SingleChildScrollView(
        padding:
            const EdgeInsets.all(16),

        child: Form(
          key: _formKey,

          child: Column(
            children: [

              // PROFILE HEADER

              Container(
                width: double.infinity,
                padding:
                    const EdgeInsets.all(
                  24,
                ),

                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                      BorderRadius.circular(
                    24,
                  ),

                  boxShadow: const [
                    BoxShadow(
                      color:
                          Colors.black12,
                      blurRadius: 8,
                      offset:
                          Offset(0, 4),
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
                        Icons.person,
                        size: 50,
                        color:
                            Colors.red.shade700,
                      ),
                    ),

                    const SizedBox(
                        height: 12),

                    const Text(
                      "Edit Your Profile",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight:
                            FontWeight.bold,
                      ),
                    ),

                    const SizedBox(
                        height: 6),

                    Text(
                      "Update your emergency information",
                      style: TextStyle(
                        color: Colors
                            .grey.shade600,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // FORM CARD

              Container(
                padding:
                    const EdgeInsets.all(
                  20,
                ),

                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                      BorderRadius.circular(
                    24,
                  ),

                  boxShadow: const [
                    BoxShadow(
                      color:
                          Colors.black12,
                      blurRadius: 8,
                      offset:
                          Offset(0, 4),
                    ),
                  ],
                ),

                child: Column(
                  children: [

                    buildTextField(
                      controller:
                          nameController,
                      label:
                          "Full Name",
                      icon:
                          Icons.person,
                    ),

                    const SizedBox(
                        height: 18),

                    buildTextField(
                      controller:
                          phoneController,
                      label:
                          "Phone Number",
                      icon:
                          Icons.phone,
                    ),

                    const SizedBox(
                        height: 18),

                    buildTextField(
                      controller:
                          bloodController,
                      label:
                          "Blood Group",
                      icon: Icons.bloodtype,
                    ),
                    const SizedBox(height: 18),

TextFormField(
  controller: medicalController,
  maxLines: 3,
  decoration: InputDecoration(
    prefixIcon: Icon(
      Icons.medical_information,
      color: Colors.red.shade700,
    ),
    labelText: "Medical Notes",
    filled: true,
    fillColor: Colors.grey.shade50,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
    ),
  ),
),

const SizedBox(height: 18),

TextFormField(
  controller: additionalController,
  maxLines: 3,
  decoration: InputDecoration(
    prefixIcon: Icon(
      Icons.info_outline,
      color: Colors.red.shade700,
    ),
    labelText: "Additional Information",
    filled: true,
    fillColor: Colors.grey.shade50,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
    ),
  ),
),

                    const SizedBox(
                        height: 30),

                    SizedBox(
                      width:
                          double.infinity,
                      height: 55,

                      child:
                          ElevatedButton.icon(
                        icon: const Icon(
                          Icons.save,
                        ),

                        onPressed:
                            saveProfile,

                        style:
                            ElevatedButton
                                .styleFrom(
                          backgroundColor:
                              Colors
                                  .red
                                  .shade700,

                          shape:
                              RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(
                              16,
                            ),
                          ),
                        ),

                        label:
                            const Text(
                          "Save Changes",
                          style:
                              TextStyle(
                            fontSize:
                                18,
                            fontWeight:
                                FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  @override
void dispose() {
  nameController.dispose();
  phoneController.dispose();
  bloodController.dispose();
  medicalController.dispose();
  additionalController.dispose();
  super.dispose();
}
}