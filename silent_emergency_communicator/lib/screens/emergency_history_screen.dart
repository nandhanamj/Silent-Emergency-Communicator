import 'package:flutter/material.dart';

import '../models/emergency_history.dart';
import '../services/history_storage_service.dart';

class EmergencyHistoryScreen
    extends StatefulWidget {
  const EmergencyHistoryScreen({
    super.key,
  });

  @override
  State<EmergencyHistoryScreen>
      createState() =>
          _EmergencyHistoryScreenState();
}

class _EmergencyHistoryScreenState
    extends State<EmergencyHistoryScreen> {
  List<EmergencyHistory> histories =
      [];

  @override
  void initState() {
    super.initState();
    loadHistory();
  }

  Future<void> loadHistory() async {
    final data =
        await HistoryStorageService
            .getHistories();

    setState(() {
      histories = data.reversed.toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
  backgroundColor: const Color(0xFFF8F9FC),
      appBar: AppBar(
  title: const Text(
    "Emergency History",
  ),
  elevation: 0,
  backgroundColor: Colors.white,
  foregroundColor: Colors.black,
  actions: [
  IconButton(
    icon: const Icon(
      Icons.delete_sweep,
    ),
    onPressed: () async {
  await HistoryStorageService
      .clearHistory();

  loadHistory();
},
  ),
],
),
      body: histories.isEmpty
          ? Center(
  child: Column(
    mainAxisAlignment:
        MainAxisAlignment.center,
    children: [
      Icon(
        Icons.history_toggle_off,
        size: 90,
        color: Colors.grey.shade400,
      ),
      const SizedBox(height: 16),
      const Text(
        "No Emergency Alerts Yet",
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
      const SizedBox(height: 8),
      Text(
        "Your emergency activities will appear here",
        style: TextStyle(
          color: Colors.grey.shade600,
        ),
      ),
    ],
  ),
)
          : ListView.builder(
              itemCount:
                  histories.length,
              itemBuilder:
                  (context, index) {
                final history =
                    histories[index];

               return Container(
  margin: const EdgeInsets.symmetric(
    horizontal: 16,
    vertical: 8,
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

  child: Row(
    crossAxisAlignment:
        CrossAxisAlignment.start,
    children: [

      Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          color: Colors.red.shade50,
          shape: BoxShape.circle,
        ),
        child: Icon(
          Icons.emergency,
          color: Colors.red.shade700,
        ),
      ),

      const SizedBox(width: 16),

      Expanded(
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,
          children: [

            Text(
              history.emergencyType,
              style: const TextStyle(
                fontSize: 18,
                fontWeight:
                    FontWeight.bold,
              ),
            ),

            const SizedBox(height: 6),

            Row(
              children: [
                Icon(
                  Icons.access_time,
                  size: 16,
                  color:
                      Colors.grey.shade600,
                ),

                const SizedBox(width: 4),

                Expanded(
                  child: Text(
                    history.dateTime,
                    style: TextStyle(
                      color:
                          Colors.grey.shade600,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 10),

            Container(
              padding:
                  const EdgeInsets.all(10),
              decoration:
                  BoxDecoration(
                color:
                    Colors.grey.shade100,
                borderRadius:
                    BorderRadius.circular(
                  12,
                ),
              ),

              child: Text(
                "Recipients:\n${history.recipients.join(', ')}",
              ),
            ),
          ],
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