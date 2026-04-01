// lib/screens/chat_list_screen.dart
import 'package:flutter/material.dart';
import 'package:srichat/screens/chat_screen.dart';

class ChatListScreen extends StatelessWidget {
  const ChatListScreen({super.key});

  final List<Map<String, String>> chatData = const [
    {'name': 'ZZaza cantik', 'time': 'Now', 'message': 'Pe'},
    {'name': 'Nova', 'time': '2 Min', 'message': 'Ok, see you later!'},
    {'name': 'salma', 'time': '1 Hour', 'message': 'Thank you 😍'},
    {'name': 'Wahyu Pangestu', 'time': '10:40 AM', 'message': 'Meeting at 4PM'},
    // ... tambahkan data lainnya
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: chatData.length,
      itemBuilder: (context, index) {
        final chat = chatData[index];
        return ListTile(
          leading: const CircleAvatar(
            backgroundColor: Color.fromARGB(250, 254, 253, 254),
            child: Icon(Icons.person, color: Color.fromARGB(255, 240, 238, 239)),
          ),
          title: Text(chat['name']!, style: const TextStyle(color: Color.fromARGB(255, 240, 237, 241), fontWeight: FontWeight.bold)),
          subtitle: Text(chat['message']!, style: const TextStyle(color: Color.fromARGB(255, 242, 238, 241))),
          trailing: Text(chat['time']!, style: const TextStyle(color: Color.fromARGB(252, 222, 220, 222), fontSize: 12)),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ChatScreen(contactName: chat['name']!),
              ),
            );
          },
        );
      },
    );
  }
}