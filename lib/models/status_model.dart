// lib/models/status_model.dart
class Status {
  String userName;
  String userProfilePic;
  String time;
  List<String> statusItems; // Bisa lebih dari 1
  bool isMyStatus;

  Status({
    required this.userName,
    required this.userProfilePic,
    required this.time,
    required this.statusItems,
    this.isMyStatus = false,
  });
}
