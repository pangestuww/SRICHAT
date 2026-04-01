// lib/main.dart
import 'package:flutter/material.dart';
import 'package:srichat/screens/create_account_screen.dart';

void main() {
  runApp(const SriCHAT());
}

class SriCHAT extends StatelessWidget {
  const SriCHAT({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SriCHAT',
      debugShowCheckedModeBanner: false,
      // Di dalam MaterialApp
theme: ThemeData(
    primarySwatch: Colors.purple,
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: const Color.fromARGB(255, 255, 255, 255),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.0),
        borderSide: BorderSide.none,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        foregroundColor: const Color(0xFF7B68EE),
        padding: const EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    ),
),
      home: const CreateAccountScreen(), // Layar awal aplikasi
    );
  }
}