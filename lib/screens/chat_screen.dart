// lib/screens/chat_screen.dart
import 'package:flutter/material.dart';
import 'dart:async';

class ChatScreen extends StatefulWidget {
  final String contactName;

  const ChatScreen({super.key, required this.contactName});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final List<Map<String, String>> _messages = [];
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final statusBarHeight = MediaQuery.of(context).padding.top;
    final appBarHeight = kToolbarHeight;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.contactName,
          style: const TextStyle(
              color: Color.fromARGB(255, 228, 57, 168),
              fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Color.fromARGB(255, 243, 10, 200)),
      ),
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
        child: Padding(
          padding: EdgeInsets.only(top: statusBarHeight + appBarHeight),
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.all(16.0),
                  itemCount: _messages.length,
                  itemBuilder: (context, index) {
                    final message = _messages[index];
                    return _buildMessageBubble(
                        message['text']!, message['time']!, message['isMe']! == 'true');
                  },
                ),
              ),
              _buildMessageInput(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMessageBubble(String message, String time, bool isMe) {
    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isMe ? Colors.white : const Color(0xFFE1BEE7),
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(16),
            topRight: const Radius.circular(16),
            bottomLeft: isMe ? const Radius.circular(16) : const Radius.circular(4),
            bottomRight: isMe ? const Radius.circular(4) : const Radius.circular(16),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(message, style: TextStyle(color: isMe ? Colors.black87 : Colors.black87)),
            const SizedBox(height: 4),
            Text(time, style: TextStyle(fontSize: 10, color: Colors.grey[600])),
          ],
        ),
      ),
    );
  }

  Widget _buildMessageInput() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      color: Colors.white,
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _controller,
              decoration: const InputDecoration(
                hintText: 'Type a message...',
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(horizontal: 16),
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.send, color: Color(0xFF7B68EE)),
            onPressed: _sendMessage,
          ),
        ],
      ),
    );
  }

  void _sendMessage() {
    final text = _controller.text.trim();
    if (text.isEmpty) return;

    final time = TimeOfDay.now().format(context);
    setState(() {
      _messages.add({'text': text, 'time': time, 'isMe': 'true'});
    });
    _controller.clear();

    // Respon otomatis setelah 1 detik
    Timer(const Duration(seconds: 1), () {
      final autoReplyTime = TimeOfDay.now().format(context);
      setState(() {
        _messages.add({
          'text': _generateAutoReply(text),
          'time': autoReplyTime,
          'isMe': 'false'
        });
      });
    });
  }

  String _generateAutoReply(String userMessage) {
    // Contoh dummy: balasan sederhana
    final replies = [
      'Oh, I see!',
      'Interesting 🤔',
      'Haha, really?',
      'Can you explain more?',
      'Got it!',
      'Thanks for letting me know!',
    ];
    // Pilih random reply
    replies.shuffle();
    return replies.first;
  }
}
