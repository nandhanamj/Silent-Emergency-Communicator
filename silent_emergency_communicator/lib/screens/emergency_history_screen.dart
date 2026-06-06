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
      appBar: AppBar(
        title: const Text(
          "Emergency History",
        ),
      ),
      body: histories.isEmpty
          ? const Center(
              child: Text(
                "No alerts sent yet",
              ),
            )
          : ListView.builder(
              itemCount:
                  histories.length,
              itemBuilder:
                  (context, index) {
                final history =
                    histories[index];

                return Card(
                  margin:
                      const EdgeInsets.all(
                    10,
                  ),
                  child: ListTile(
                    leading: const Icon(
                      Icons.history,
                    ),
                    title: Text(
                      history
                          .emergencyType,
                    ),
                    subtitle: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment
                              .start,
                      children: [
                        Text(
                          history.dateTime,
                        ),
                        Text(
                          "Recipients: ${history.recipients.join(', ')}",
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}