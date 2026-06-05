import 'package:flutter/material.dart';
import 'emergency_message_generator_screen.dart';

class EmergencyProcessingScreen extends StatefulWidget {
  final String emergencyType;

  const EmergencyProcessingScreen({
    super.key,
    required this.emergencyType,
  });

  @override
  State<EmergencyProcessingScreen> createState() =>
      _EmergencyProcessingScreenState();
}

class _EmergencyProcessingScreenState
    extends State<EmergencyProcessingScreen> {

  bool identified = false;
  bool profileLoaded = false;
  bool messagePrepared = false;
  bool readyToSend = false;

  @override
  void initState() {
    super.initState();
    startProcessing();
  }

  Future<void> startProcessing() async {

    await Future.delayed(const Duration(seconds: 1));

    setState(() {
      identified = true;
    });

    await Future.delayed(const Duration(seconds: 1));

    setState(() {
      profileLoaded = true;
    });

    await Future.delayed(const Duration(seconds: 1));

    setState(() {
      messagePrepared = true;
    });

    await Future.delayed(const Duration(seconds: 1));

    setState(() {
      readyToSend = true;
    });
  }

  Widget buildStep(
    String title,
    bool completed,
  ) {
    return ListTile(
      leading: Icon(
        completed
            ? Icons.check_circle
            : Icons.hourglass_top,
      ),
      title: Text(title),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.emergencyType),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [

            const SizedBox(height: 20),

            Text(
              "${widget.emergencyType} Emergency",
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 30),

            buildStep(
              "Emergency Identified",
              identified,
            ),

            buildStep(
              "User Profile Loaded",
              profileLoaded,
            ),

            buildStep(
              "Message Prepared",
              messagePrepared,
            ),

            buildStep(
              "Ready To Send",
              readyToSend,
            ),

            const Spacer(),

            if (readyToSend)
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (_) =>
          EmergencyMessageGeneratorScreen(
        emergencyType:
            widget.emergencyType,
      ),
    ),
  );
},
                  child: const Text(
                    "Continue",
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}