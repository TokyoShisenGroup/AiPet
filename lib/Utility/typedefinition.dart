import 'package:flutter/material.dart';

class User {
  final String name;
  final String avatarUrl;
  final String email;
  final int userid;
  User({required this.name, required this.avatarUrl, required this.email,required this.userid});
}

class Chat {
  final User friend;
  final String lastMessage;

  Chat({required this.friend, required this.lastMessage});
}

// class Message {
//   final String sender;
//   final String content;
//   final DateTime timestamp;
//
//   Message(
//       {required this.sender, required this.content, required this.timestamp});
// }

class Pet {
  final String name;
  final String type;

  Pet({required this.name, required this.type});
}

class Reminder {
  final String description;
  final TimeOfDay time;

  Reminder({required this.description, required this.time});
}

class Friend {
  final String username;
  final int userid;
  Friend({required this.username, required this.userid});
}
