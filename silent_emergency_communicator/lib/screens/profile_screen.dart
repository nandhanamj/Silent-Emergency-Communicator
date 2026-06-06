import 'package:flutter/material.dart';

import '../services/storage_service.dart';
import 'edit_profile_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() =>
      _ProfileScreenState();
}

class _ProfileScreenState
    extends State<ProfileScreen> {

  Map<String, dynamic> profile = {};

  @override
  void initState() {
    super.initState();
    loadProfile();
  }

  Future<void> loadProfile() async {
    final data =
        await StorageService.getUserProfile();

    setState(() {
      profile = data;
    });
  }
  Widget profileInfoCard(
  IconData icon,
  String title,
  String value,
  Color color,
) {
  return Container(
    width: double.infinity,
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
          backgroundColor:
              color.withOpacity(0.1),
          child: Icon(
            icon,
            color: color,
          ),
        ),

        const SizedBox(width: 15),

        Expanded(
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 13,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 17,
                  fontWeight:
                      FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
  backgroundColor: const Color(0xFFF8F9FC),
      appBar: AppBar(
  title: const Text("Profile"),
  elevation: 0,
  backgroundColor: Colors.white,
  foregroundColor: Colors.black,
),
      body: SingleChildScrollView(
  padding: const EdgeInsets.all(20),
  child: Column(
    children: [

      // Profile Header

      Container(
        width: double.infinity,
        padding: const EdgeInsets.all(24),
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
        child: Column(
          children: [

            CircleAvatar(
              radius: 45,
              backgroundColor: Colors.red.shade50,
              child: Icon(
                Icons.person,
                size: 50,
                color: Colors.red.shade700,
              ),
            ),

            const SizedBox(height: 15),

            Text(
              profile['fullName'] ?? "User",
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 5),

            const Text(
              "Emergency User",
              style: TextStyle(
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),

      const SizedBox(height: 25),

      // Phone Card

      profileInfoCard(
        Icons.phone,
        "Phone Number",
        profile['phoneNumber'] ?? "Not Added",
        Colors.green,
      ),

      const SizedBox(height: 15),

      // Blood Group Card

      profileInfoCard(
        Icons.bloodtype,
        "Blood Group",
        profile['bloodGroup'] ?? "Not Added",
        Colors.red,
      ),

      const SizedBox(height: 30),

      SizedBox(
        width: double.infinity,
        height: 55,
        child: ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red.shade700,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          ),
          icon: const Icon(
            Icons.edit,
            color: Colors.white,
          ),
          label: const Text(
            "Edit Profile",
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          onPressed: () async {
            final result =
                await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) =>
                    EditProfileScreen(
                  profile: profile,
                ),
              ),
            );

            if (result == true) {
              loadProfile();
            }
          },
        ),
      ),
    ],
  ),
),
    );
  }
}