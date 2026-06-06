class EmergencyHistory {
  final String emergencyType;
  final String dateTime;
  final String message;
  final List<String> recipients;

  EmergencyHistory({
    required this.emergencyType,
    required this.dateTime,
    required this.message,
    required this.recipients,
  });

  Map<String, dynamic> toJson() {
    return {
      'emergencyType': emergencyType,
      'dateTime': dateTime,
      'message': message,
      'recipients': recipients,
    };
  }

  factory EmergencyHistory.fromJson(
      Map<String, dynamic> json) {
    return EmergencyHistory(
      emergencyType: json['emergencyType'],
      dateTime: json['dateTime'],
      message: json['message'],
      recipients:
          List<String>.from(json['recipients']),
    );
  }
}