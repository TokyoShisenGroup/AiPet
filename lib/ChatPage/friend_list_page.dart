import 'package:flutter/material.dart';
import 'package:aipet/Utility/typedefinition.dart';

class FriendsListPage extends StatelessWidget {
  FriendsListPage({super.key});
  final List<User> friends = [
    User(userid:1,name: 'Alice', avatarUrl: 'https://example.com/avatar1.png', email: 'alice@example.com'),
    User(userid:2,name: 'Bob', avatarUrl: 'https://example.com/avatar2.png', email: 'bob@example.com'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Friends List'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              // Navigate to Add Friend Page
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: friends.length,
        itemBuilder: (context, index) {
          final friend = friends[index];
          return ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(friend.avatarUrl),
            ),
            title: Text(friend.name),
            subtitle: Text(friend.email),
            onTap: () {
              // Navigate to Chat Page
            },
          );
        },
      ),
    );
  }
}