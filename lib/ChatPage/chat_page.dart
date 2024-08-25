import 'package:flutter/material.dart';
import 'package:aipet/message.pb.dart'; // 导入生成的 Dart 文件
import 'package:aipet/Utility/typedefinition.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:web_socket_channel/status.dart' as status;
import 'dart:typed_data';

class ChatPage extends StatefulWidget {
  final User friend;

  const ChatPage({super.key, required this.friend});

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final List<Message> messages = [];
  final TextEditingController _controller = TextEditingController();
  late WebSocketChannel channel;

  @override
  void initState() {
    super.initState();
    channel = WebSocketChannel.connect(
      Uri.parse('ws://192.168.1.7:8081/ws'),
    );

    channel.stream.listen(
          (message) {
        if (message is String) {
          message = Uint8List.fromList(message.codeUnits);
        } else if (message is List<int>) {
          message = Uint8List.fromList(message);
        }

        try {
          final decodedMessage = Message.fromBuffer(message);
          setState(() {
            messages.add(decodedMessage);
          });
        } catch (e) {
          print('Failed to decode message: $e');
        }
      },
      onError: (error) {
        print('Error: $error');
      },
      onDone: () {
        print('Connection closed');
      },
    );
  }

  void _sendMessage() {
    final message = Message()
      ..from = 'me'
      ..to = widget.friend.name
      ..content = _controller.text
      ..contentType = 1
      ..type = 'text'
      ..messageType = 1
      ..url = ''
      ..file = [];

    channel.sink.add(message.writeToBuffer());

    setState(() {
      messages.add(message);
    });
    _controller.clear();
  }

  @override
  void dispose() {
    channel.sink.close(status.goingAway);
    super.dispose();
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
                  title: Text(message.from),
                  subtitle: Text(message.content),
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