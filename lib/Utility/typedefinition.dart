import 'dart:ffi';

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
  String    name;
  String    type;
  String    kind;
  double    weight;
  DateTime  birthday;
  Pet({required this.name, required this.type, required this.kind, required this.weight, required this.birthday});
  Map<String, dynamic> toJson() => {
    'name': name,
    'type': type,
    'kind': kind,
    'weight': weight,
    'birthday': birthday.toIso8601String(),
    'OwnerName':'Mitsuhiro',
  };
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
