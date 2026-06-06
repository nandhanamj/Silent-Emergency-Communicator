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
      appBar: AppBar(
        title: const Text(
          "Language Settings",
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            DropdownButtonFormField<String>(
              value: selectedLanguage,
              decoration: const InputDecoration(
                labelText: "Select Language",
                border: OutlineInputBorder(),
              ),
              items: const [
                DropdownMenuItem(
                  value: "English",
                  child: Text("English"),
                ),
                DropdownMenuItem(
                  value: "Malayalam",
                  child: Text("Malayalam"),
                ),
                DropdownMenuItem(
                  value: "Hindi",
                  child: Text("Hindi"),
                ),
                DropdownMenuItem(
                  value: "Tamil",
                  child: Text("Tamil"),
                ),
              ],
              onChanged: (value) {
                setState(() {
                  selectedLanguage =
                      value ?? "English";
                });
              },
            ),

            const SizedBox(height: 20),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: saveLanguage,
                child: const Text(
                  "Save Language",
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}