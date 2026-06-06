import 'package:flutter/material.dart';

class NetworkBanner extends StatelessWidget {
  final bool isOnline;

  const NetworkBanner({
    super.key,
    required this.isOnline,
  });

  @override
  Widget build(BuildContext context) {
    if (isOnline) {
      return const SizedBox();
    }

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(10),
      color: Colors.red,
      child: const Text(
        "⚠ Offline Mode - SMS only",
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}