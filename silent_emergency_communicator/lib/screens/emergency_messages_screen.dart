import 'package:flutter/material.dart';

class EmergencyMessagesScreen extends StatefulWidget {
  const EmergencyMessagesScreen({super.key});

  @override
  State<EmergencyMessagesScreen> createState() =>
      _EmergencyMessagesScreenState();
}

class _EmergencyMessagesScreenState
    extends State<EmergencyMessagesScreen> {

  List<Map<String, dynamic>> messages = [
    {
      "title": "Medical Emergency",
      "message":
          "Medical emergency. I need immediate help. My location is attached.",
      "icon": Icons.medical_services,
      "color": Colors.red,
    },
    {
      "title": "Police Emergency",
      "message":
          "I am in danger. Please help immediately. My location is attached.",
      "icon": Icons.local_police,
      "color": Colors.blue,
    },
    {
      "title": "Fire Emergency",
      "message":
          "Fire emergency. Please respond urgently. My location is attached.",
      "icon": Icons.local_fire_department,
      "color": Colors.orange,
    },
    {
      "title": "Danger Alert",
      "message":
          "I feel unsafe. Please check my location immediately.",
      "icon": Icons.warning,
      "color": Colors.amber,
    },
    {
      "title": "SOS",
      "message":
          "Emergency! Please help immediately. My location is attached.",
      "icon": Icons.sos,
      "color": Colors.redAccent,
    },
  ];

  void editMessage(int index) {
    TextEditingController controller =
        TextEditingController(text: messages[index]["message"]);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(messages[index]["title"]),
          content: TextField(
            controller: controller,
            maxLines: 4,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  messages[index]["message"] = controller.text;
                });

                Navigator.pop(context);
              },
              child: const Text("Save"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Emergency Messages"),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: messages.length,
        itemBuilder: (context, index) {
          final item = messages[index];

          return Card(
            margin: const EdgeInsets.only(bottom: 12),
            child: ListTile(
              leading: Icon(
                item["icon"],
                color: item["color"],
              ),
              title: Text(item["title"]),
              subtitle: Text(item["message"]),
              trailing: IconButton(
                icon: const Icon(Icons.edit),
                onPressed: () => editMessage(index),
              ),
            ),
          );
        },
      ),
    );
  }
}