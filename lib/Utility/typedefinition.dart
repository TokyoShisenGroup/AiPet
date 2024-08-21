class User {
  final String name;
  final String avatarUrl;
  final String email;

  User({required this.name, required this.avatarUrl, required this.email});
}

class Chat {
  final User friend;
  final String lastMessage;

  Chat({required this.friend, required this.lastMessage});
}

class Message {
  final String sender;
  final String content;
  final DateTime timestamp;

  Message({required this.sender, required this.content, required this.timestamp});
}