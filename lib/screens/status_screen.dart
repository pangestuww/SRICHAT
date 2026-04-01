// lib/screens/status_screen.dart
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:srichat/models/status_model.dart';
import 'package:srichat/screens/add_status_screen.dart';
import 'package:srichat/screens/view_status_screen.dart';

class StatusScreen extends StatefulWidget {
  const StatusScreen({super.key});

  @override
  State<StatusScreen> createState() => _StatusScreenState();
}

class _StatusScreenState extends State<StatusScreen> {
  List<Status> statusList = [
    Status(
      userName: "My Status",
      userProfilePic: "assets/images/srichat_logo.png",
      time: "Tap to add status update",
      statusItems: [],
      isMyStatus: true,
    ),
    Status(
      userName: "Nova",
      userProfilePic: "assets/images/status.jpg",
      time: "Today, 09:20 AM",
      statusItems: ["assets/images/status.jpg"],
    ),
    Status(
      userName: "Salma",
      userProfilePic: "assets/images/status.jpg",
      time: "Today, 10:40 AM",
      statusItems: ["assets/images/status.jpg"],
    ),
  ];

  Future<void> _addStatus() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const AddStatusScreen()),
    );

    if (result != null && result is String) {
      setState(() {
        statusList.first.statusItems.add(result);
        statusList.first.time = "Just now";
      });
    }
  }

  ImageProvider getImageProvider(String path) {
    if (path.startsWith('assets/')) {
      return AssetImage(path);
    } else {
      return FileImage(File(path));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildMyStatusTile(),
          const Divider(height: 32, color: Colors.white30),
          const Text('Viewed Updates', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          Expanded(
            child: ListView.builder(
              itemCount: statusList.length - 1,
              itemBuilder: (context, index) {
                final status = statusList[index + 1];
                return _buildFriendStatusTile(status);
              },
            ),
          )
        ],
      ),
    );
  }

  Widget _buildMyStatusTile() {
    final myStatus = statusList.first;
    return InkWell(
      onTap: _addStatus,
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          children: [
            Stack(
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.white24,
                  backgroundImage: getImageProvider(myStatus.userProfilePic),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    width: 24,
                    height: 24,
                    decoration: BoxDecoration(
                      color: const Color(0xFF7B68EE),
                      border: Border.all(color: Colors.white, width: 2),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.add, color: Colors.white, size: 16),
                  ),
                ),
              ],
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(myStatus.userName, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                  Text(myStatus.time, style: const TextStyle(color: Colors.white70)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFriendStatusTile(Status status) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => ViewStatusScreen(
              statuses: statusList,
              initialIndex: statusList.indexOf(status),
            ),
          ),
        );
      },
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          children: [
            _buildStatusBorder(status.userProfilePic, status.statusItems.isNotEmpty),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(status.userName, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                  Text(status.time, style: const TextStyle(color: Colors.white70)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusBorder(String userProfilePic, bool hasStatus) {
    return Stack(
      alignment: Alignment.center,
      children: [
        CircleAvatar(radius: 32, backgroundColor: Colors.grey[300]),
        if (hasStatus)
          CircleAvatar(
            radius: 30,
            backgroundColor: Colors.white,
            child: CircleAvatar(
              radius: 28,
              backgroundImage: getImageProvider(userProfilePic),
            ),
          )
        else
          CircleAvatar(
            radius: 30,
            backgroundImage: getImageProvider(userProfilePic),
          ),
      ],
    );
  }
}
