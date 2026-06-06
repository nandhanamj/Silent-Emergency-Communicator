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

  if (!mounted) return;
  setState(() {
    identified = true;
  });

  await Future.delayed(const Duration(seconds: 1));

  if (!mounted) return;
  setState(() {
    profileLoaded = true;
  });

  await Future.delayed(const Duration(seconds: 1));

  if (!mounted) return;
  setState(() {
    messagePrepared = true;
  });

  await Future.delayed(const Duration(seconds: 1));

  if (!mounted) return;
  setState(() {
    readyToSend = true;
  });
}

Widget buildStatusCard(
  String title,
  bool completed,
  Color color,
) {
  return Container(
    margin:
        const EdgeInsets.only(bottom: 12),

    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius:
          BorderRadius.circular(20),

      boxShadow: const [
        BoxShadow(
          color: Colors.black12,
          blurRadius: 6,
          offset: Offset(0, 3),
        ),
      ],
    ),

    child: ListTile(
      leading: Icon(
        completed
            ? Icons.check_circle
            : Icons.hourglass_top,
        color:
            completed ? color : Colors.grey,
      ),

      title: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.w600,
        ),
      ),

      trailing: completed
          ? const Icon(
              Icons.done,
              color: Colors.green,
            )
          : const SizedBox(
              width: 20,
              height: 20,
              child:
                  CircularProgressIndicator(
                strokeWidth: 2,
              ),
            ),
    ),
  );
}

@override
Widget build(BuildContext context) {

  Color emergencyColor;

  switch (widget.emergencyType) {
    case "Medical":
      emergencyColor = Colors.red;
      break;

    case "Police":
      emergencyColor = Colors.blue;
      break;

    case "Fire":
      emergencyColor = Colors.orange;
      break;

    case "Danger":
      emergencyColor = Colors.amber.shade700;
      break;

    default:
      emergencyColor = Colors.redAccent;
  }

  return Scaffold(
    backgroundColor: const Color(0xFFF8F9FC),

    appBar: AppBar(
      elevation: 0,
      backgroundColor: Colors.white,
      foregroundColor: Colors.black,
      title: const Text(
        "Emergency Processing",
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
    ),

    body: Padding(
      padding: const EdgeInsets.all(20),

      child: Column(
        children: [

          const SizedBox(height: 10),

          CircleAvatar(
            radius: 55,
            backgroundColor:
    emergencyColor.withValues(alpha: 0.15),

            child: Icon(
              Icons.warning_amber_rounded,
              size: 55,
              color: emergencyColor,
            ),
          ),

          const SizedBox(height: 20),

          Text(
            "${widget.emergencyType} Emergency",
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 8),

          Text(
            "Emergency protocol activated",
            style: TextStyle(
              color: Colors.grey.shade600,
              fontSize: 15,
            ),
          ),

          const SizedBox(height: 30),

          buildStatusCard(
            "Emergency Identified",
            identified,
            emergencyColor,
          ),

          buildStatusCard(
            "User Profile Loaded",
            profileLoaded,
            emergencyColor,
          ),

          buildStatusCard(
            "Message Prepared",
            messagePrepared,
            emergencyColor,
          ),

          buildStatusCard(
            "Ready To Send",
            readyToSend,
            emergencyColor,
          ),

          const Spacer(),

          if (!readyToSend)
            Column(
              children: [

                CircularProgressIndicator(
                  color: emergencyColor,
                ),

                const SizedBox(height: 15),

                const Text(
                  "Preparing emergency alert...",
                ),
              ],
            ),

          if (readyToSend)
            SizedBox(
              width: double.infinity,
              height: 55,

              child: ElevatedButton.icon(
                icon: const Icon(
                  Icons.arrow_forward,
                ),

                style:
                    ElevatedButton.styleFrom(
                  backgroundColor:
                      emergencyColor,

                  foregroundColor:
                      Colors.white,

                  shape:
                      RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(
                            16),
                  ),
                ),

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

                label: const Text(
                  "Continue",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight:
                        FontWeight.bold,
                  ),
                ),
              ),
            ),
        ],
      ),
    ),
  );
}
}