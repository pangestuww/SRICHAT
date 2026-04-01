// lib/screens/main_screen.dart
import 'package:flutter/material.dart';
import 'package:srichat/screens/chat_list_screen.dart';
import 'package:srichat/screens/profile_screen.dart';
import 'package:srichat/screens/status_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  final List<Widget> _tabs = [
    const ChatListScreen(),
    const StatusScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 1. Perpanjang body agar berada di belakang AppBar
      extendBodyBehindAppBar: true,
      
      // 2. Buat AppBar menjadi transparan
      appBar: AppBar(
        title: const Text(
          'SriCHAT',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.transparent, // Warna transparan
        elevation: 0, // Hilangkan bayangan
        centerTitle: true,
        automaticallyImplyLeading: false, // Tidak ada tombol kembali
      ),
      
      // 3. Bungkus body dengan Container yang memiliki gradien
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF7B68EE), 
              Color(0xFF9370DB), 
              Color(0xFFBA55D3)
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        // Tampilkan konten tab di dalam Container gradien
        child: _tabs[_currentIndex],
      ),

      // BottomNavigationBar tetap dengan background putih
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        selectedItemColor: const Color(0xFF7B68EE), // Warna ungu utama
        unselectedItemColor: Colors.grey,
        backgroundColor: Colors.white,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.chat),
            label: 'Chats',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.circle),
            label: 'Status',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}