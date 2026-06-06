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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Card(
          child: Padding(
            padding:
                const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [

                const Center(
                  child: CircleAvatar(
                    radius: 40,
                    child: Icon(
                      Icons.person,
                      size: 40,
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                Text(
                  "Name: ${profile['fullName'] ?? ''}",
                ),

                const SizedBox(height: 10),

                Text(
                  "Phone: ${profile['phoneNumber'] ?? ''}",
                ),

                const SizedBox(height: 10),

                Text(
                  "Blood Group: ${profile['bloodGroup'] ?? ''}",
                ),

                const SizedBox(height: 30),

                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
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
                    child: const Text(
                      "Edit Profile",
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