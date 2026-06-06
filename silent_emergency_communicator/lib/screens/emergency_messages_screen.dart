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
          title: Row(
  children: [
    Icon(
      messages[index]["icon"],
      color: messages[index]["color"],
    ),
    const SizedBox(width: 10),
    Expanded(
      child: Text(
        messages[index]["title"],
      ),
    ),
  ],
),
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
              style: ElevatedButton.styleFrom(
  backgroundColor:
      Colors.red.shade700,
),

child: const Text(
  "Save",
  style: TextStyle(
    color: Colors.white,
  ),
),
            ),
          ],
        );
      },
    );
  }

  void deleteMessage(int index) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text(
          "Delete Message",
        ),
        content: const Text(
          "Are you sure you want to delete this message template?",
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text(
              "Cancel",
            ),
          ),

          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
            ),
            onPressed: () {
              setState(() {
                messages.removeAt(index);
              });

              Navigator.pop(context);
            },
            child: const Text(
              "Delete",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ],
      );
    },
  );
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
  backgroundColor: const Color(0xFFF8F9FC),
      appBar: AppBar(
  title: const Text(
    "Emergency Messages",
  ),
  elevation: 0,
  backgroundColor: Colors.white,
  foregroundColor: Colors.black,
),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: messages.length,
        itemBuilder: (context, index) {
          final item = messages[index];

         return Container(
  margin: const EdgeInsets.only(
    bottom: 16,
  ),
  padding: const EdgeInsets.all(16),
  decoration: BoxDecoration(
    color: Colors.white,
    borderRadius:
        BorderRadius.circular(20),
    boxShadow: const [
      BoxShadow(
        color: Colors.black12,
        blurRadius: 8,
        offset: Offset(0, 4),
      ),
    ],
  ),

  child: Column(
    crossAxisAlignment:
        CrossAxisAlignment.start,
    children: [

      Row(
        children: [

          CircleAvatar(
            backgroundColor:
                (item["color"] as Color)
                    .withOpacity(0.15),

            child: Icon(
              item["icon"],
              color: item["color"],
            ),
          ),

          const SizedBox(width: 12),

          Expanded(
            child: Text(
              item["title"],
              style: const TextStyle(
                fontSize: 18,
                fontWeight:
                    FontWeight.bold,
              ),
            ),
          ),

          PopupMenuButton<String>(
  onSelected: (value) {
    if (value == "edit") {
      editMessage(index);
    }

    if (value == "delete") {
      deleteMessage(index);
    }
  },

  itemBuilder: (context) => [
    const PopupMenuItem(
      value: "edit",
      child: Row(
        children: [
          Icon(Icons.edit),
          SizedBox(width: 8),
          Text("Edit"),
        ],
      ),
    ),

    const PopupMenuItem(
      value: "delete",
      child: Row(
        children: [
          Icon(
            Icons.delete,
            color: Colors.red,
          ),
          SizedBox(width: 8),
          Text(
            "Delete",
            style: TextStyle(
              color: Colors.red,
            ),
          ),
        ],
      ),
    ),
  ],
),
        ],
      ),

      const SizedBox(height: 12),

      Container(
        width: double.infinity,
        padding:
            const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.grey.shade100,
          borderRadius:
              BorderRadius.circular(
            14,
          ),
        ),

        child: Text(
          item["message"],
          style: const TextStyle(
            height: 1.5,
          ),
        ),
      ),
    ],
  ),
);
        },
      ),
    );
  }
}