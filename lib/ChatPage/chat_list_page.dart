import 'package:flutter/material.dart';
import 'package:aipet/Utility/typedefinition.dart';
import "package:aipet/ChatPage/chat_page.dart"; // Import the chat page

class ChatListPage extends StatelessWidget {
  ChatListPage({super.key});
  final List<Chat> chats = [
    Chat(friend: User(userid:1,name: 'Alice', avatarUrl: 'https://avatars.githubusercontent.com/u/68729861?v=4', email: 'alice@example.com'), lastMessage: 'Hello!'),
    Chat(friend: User(userid:2,name: 'Bob', avatarUrl: 'https://avatars.githubusercontent.com/u/68729861?v=4', email: 'bob@example.com'), lastMessage: 'How are you?'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chats'),
      ),
      body: ListView.builder(
        itemCount: chats.length,
        itemBuilder: (context, index) {
          final chat = chats[index];
          return ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(chat.friend.avatarUrl),
            ),
            title: Text(chat.friend.name),
            subtitle: Text(chat.lastMessage),
            onTap: () {
              // Navigate to Chat Page
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ChatPage(friend: chat.friend),
                ),
              );
            },
          );
        },
      ),
    );
  }
}