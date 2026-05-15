// Desenvolvido por: Vinicius Montuani e Pietro Rennó

import 'package:flutter/material.dart';
import '../widgets/glass_box.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final List<Map<String, dynamic>> _messages = [
    {'text': 'A escuridão se aproxima.', 'isMe': false},
    {'text': 'E nós a receberemos.', 'isMe': true},
    {'text': 'Excelente. A interface está verdadeiramente gótica.', 'isMe': false},
  ];

  final _controller = TextEditingController();

  void _sendMessage() {
    if (_controller.text.isEmpty) return;
    setState(() {
      _messages.add({'text': _controller.text, 'isMe': true});
      _controller.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        title: const Text('Mensagens Diretas'),
        backgroundColor: Colors.black.withValues(alpha: 0.5),
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final msg = _messages[index];
                return _buildMessageBubble(msg['text'], msg['isMe']);
              },
            ),
          ),
          _buildMessageInput(),
        ],
      ),
    );
  }

  Widget _buildMessageBubble(String text, bool isMe) {
    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 5),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: isMe ? Colors.blueGrey.withValues(alpha: 0.8) : Colors.white.withValues(alpha: 0.1),
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(15),
            topRight: const Radius.circular(15),
            bottomLeft: Radius.circular(isMe ? 15 : 0),
            bottomRight: Radius.circular(isMe ? 0 : 15),
          ),
          border: Border.all(color: Colors.white24, width: 0.5),
        ),
        child: Text(
          text,
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  Widget _buildMessageInput() {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: GlassBox(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: _controller,
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                  hintText: 'Escreva uma mensagem...',
                  hintStyle: TextStyle(color: Colors.white54),
                  border: InputBorder.none,
                ),
              ),
            ),
            const SizedBox(width: 10),
            CircleAvatar(
              backgroundColor: Colors.blueGrey.withValues(alpha: 0.8),
              child: IconButton(
                icon: const Icon(Icons.send, color: Colors.white),
                onPressed: _sendMessage,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
