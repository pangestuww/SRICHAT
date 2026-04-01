// lib/screens/add_status_screen.dart
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddStatusScreen extends StatelessWidget {
  const AddStatusScreen({super.key});

  Future<void> _pickImage(BuildContext context, ImageSource source) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);

    if (pickedFile != null) {
      Navigator.pop(context, pickedFile.path); // Kembalikan path file
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Status"),
        backgroundColor: const Color(0xFF7B68EE),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton.icon(
              onPressed: () => _pickImage(context, ImageSource.camera),
              icon: const Icon(Icons.camera_alt),
              label: const Text("Take Photo with Camera"),
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: () => _pickImage(context, ImageSource.gallery),
              icon: const Icon(Icons.photo_library),
              label: const Text("Choose from Gallery"),
            ),
          ],
        ),
      ),
    );
  }
}
