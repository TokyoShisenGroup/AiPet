import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:aipet/Utility/typedefinition.dart';

/// 发送GET请求并返回数据
Future<Map<String, dynamic>> fetchData(String url) async {
  final response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    return jsonDecode(response.body);
  } else {
    throw Exception('Failed to load data');
  }
}


User fetchUserData(String url) {
    final User user = User(
    userid: 3,
    name: 'cliecy',
    avatarUrl: 'https://avatars.githubusercontent.com/u/68729861?v=4',
    email: 'guanjiezou@gmail.com',
  );
  return user;
}

/// 发送POST请求并返回创建的数据
Future<Map<String, dynamic>> postData(String url, Map<String, String> body) async {
  final response = await http.post(
    Uri.parse(url),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(body),
  );

  if (response.statusCode == 201) {
    return jsonDecode(response.body);
  } else {
    throw Exception('Failed to create data');
  }
}

Future<Map<String, dynamic>> fetchFriends(int id) async {
  final url = 'https://jsonplaceholder.typicode.com/posts/$id';
  final response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    return jsonDecode(response.body);
  } else {
    throw Exception('Failed to load data');
  }
}
/// 示例：获取特定ID的帖子数据
// Future<Map<String, dynamic>> fetchPost(int id) async {
//   final url = 'https://jsonplaceholder.typicode.com/posts/$id';
//   return await fetchData(url);
// }

// /// 示例：创建一个新的帖子
// Future<Map<String, dynamic>> createPost(String title, String body, String userId) async {
//   const url = 'https://jsonplaceholder.typicode.com/posts';
//   final thePostData = {
//     'title': title,
//     'body': body,
//     'userId': userId,
//   };
//   return await postData(url, thePostData);
// }

