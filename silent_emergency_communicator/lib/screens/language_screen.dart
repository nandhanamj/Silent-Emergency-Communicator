import 'package:flutter/material.dart';

import '../services/language_service.dart';

class LanguageScreen extends StatefulWidget {
  const LanguageScreen({super.key});

  @override
  State<LanguageScreen> createState() =>
      _LanguageScreenState();
}

class _LanguageScreenState
    extends State<LanguageScreen> {
  String selectedLanguage = "English";

  @override
  void initState() {
    super.initState();
    loadLanguage();
  }

  Future<void> loadLanguage() async {
    final language =
        await LanguageService.getLanguage();

    setState(() {
      selectedLanguage = language;
    });
  }

  Future<void> saveLanguage() async {
    await LanguageService.saveLanguage(
      selectedLanguage,
    );

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          "Language Saved",
        ),
      ),
    );
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
    "Language Settings",
    style: TextStyle(
      fontWeight: FontWeight.bold,
    ),
  ),
),
     body: SingleChildScrollView(
  padding: const EdgeInsets.all(16),

  child: Column(
    children: [

      Container(
        width: double.infinity,
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

            CircleAvatar(
              radius: 40,
              backgroundColor:
                  Colors.red.shade50,

              child: Icon(
                Icons.language,
                size: 40,
                color: Colors.red.shade700,
              ),
            ),

            const SizedBox(height: 16),

            const Text(
              "Choose Your Preferred Language",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                fontWeight:
                    FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),

            Text(
              "Emergency messages and app settings will use this language.",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.grey.shade600,
              ),
            ),

            const SizedBox(height: 30),

            DropdownButtonFormField<String>(
              value: selectedLanguage,

              decoration: InputDecoration(
                labelText:
                    "Select Language",

                prefixIcon:
                    const Icon(Icons.translate),

                border:
                    OutlineInputBorder(
                  borderRadius:
                      BorderRadius.circular(
                    16,
                  ),
                ),
              ),

              items: const [

                DropdownMenuItem(
                  value: "English",
                  child: Text(
                    "🇬🇧 English",
                  ),
                ),

                DropdownMenuItem(
                  value: "Malayalam",
                  child: Text(
                    "🇮🇳 Malayalam",
                  ),
                ),

                DropdownMenuItem(
                  value: "Hindi",
                  child: Text(
                    "🇮🇳 Hindi",
                  ),
                ),

                DropdownMenuItem(
                  value: "Tamil",
                  child: Text(
                    "🇮🇳 Tamil",
                  ),
                ),
              ],

              onChanged: (value) {
                setState(() {
                  selectedLanguage =
                      value ?? "English";
                });
              },
            ),

            const SizedBox(height: 30),

            SizedBox(
              width: double.infinity,
              height: 55,

              child: ElevatedButton.icon(
                onPressed:
                    saveLanguage,

                icon: const Icon(
                  Icons.save,
                  color: Colors.white,
                ),

                label: const Text(
                  "Save Language",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight:
                        FontWeight.bold,
                  ),
                ),

                style:
                    ElevatedButton.styleFrom(
                  backgroundColor:
                      Colors.red.shade700,

                  shape:
                      RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(
                      16,
                    ),
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
    );
  }
}