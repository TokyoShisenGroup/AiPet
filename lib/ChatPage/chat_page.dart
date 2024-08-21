import 'package:flutter/material.dart';
import 'package:aipet/Utility/typedefinition.dart';

class ChatPage extends StatefulWidget {
  final User friend;

  ChatPage({required this.friend});

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final List<Message> messages = [];
  final TextEditingController _controller = TextEditingController();

  void _sendMessage() {
    final message = Message(
      sender: 'me',
      content: _controller.text,
      timestamp: DateTime.now(),
    );
    setState(() {
      messages.add(message);
    });
    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.friend.name),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final message = messages[index];
                return ListTile(
                  title: Text(message.sender),
                  subtitle: Text(message.content),
                  trailing: Text(message.timestamp.toString()),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: const InputDecoration(
                      hintText: 'Enter message',
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: _sendMessage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}