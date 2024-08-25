import 'dart:convert';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:aipet/message.pb.dart'; // 导入生成的 Dart 文件

import 'dart:typed_data';

void main() {
  final channel = WebSocketChannel.connect(
    Uri.parse('ws://localhost:8080/ws'),
  );

  channel.stream.listen(
        (message) {
      // 确保 message 是字节数组
      if (message is String) {
        message = Uint8List.fromList(message.codeUnits);
      } else if (message is List<int>) {
        message = Uint8List.fromList(message);
      }

      try {
        final decodedMessage = Message.fromBuffer(message);
        print('Received: ${decodedMessage.content}');
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

  // 创建并发送消息
  final message = Message()
    ..from = 'DartClient'
    ..to = 'Server'
    ..content = 'Hello from Dart!'
    ..contentType = 1
    ..type = 'text'
    ..messageType = 1
    ..url = ''
    ..file = List<int>.from(utf8.encode(''));

  channel.sink.add(message.writeToBuffer());
}