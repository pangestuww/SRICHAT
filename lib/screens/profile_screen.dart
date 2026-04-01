// lib/screens/profile_screen.dart
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Profil', style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
          SizedBox(height: 24),
          CircleAvatar(radius: 60, backgroundColor: Colors.white24, child: Icon(Icons.person, color: Colors.white, size: 60)),
          SizedBox(height: 32),
          Text('Name: Dimass', style: TextStyle(color: Colors.white)),
          SizedBox(height: 8),
          Text('About: baik', style: TextStyle(color: Colors.white)),
          SizedBox(height: 8),
          Text('Number: +628123456789', style: TextStyle(color: Colors.white)),
        ],
      ),
    );
  }
}