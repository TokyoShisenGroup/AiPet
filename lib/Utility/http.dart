import 'package:flutter/services.dart';
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

Future<Map<String, dynamic>> createPost(String title, String body, String userId) async {
  const url = 'http://jsonplaceholder.typicode.com/posts';
  final thePostData = {
    'title': title,
    'body': body,
    'userId': userId,
  };
  return await postData(url, thePostData);
}

Future<void> savePetToBackend(Pet pet) async {
    final url = 'http://34.84.255.8:8080/pets/'; // 替换为你的API端点 
    final response = await http.post(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(pet.toJson()),
    );

    if (response.statusCode == 200) {
      // 如果服务器返回了一个成功的响应
      print('Pet added successfully');
    } else {
      print(response.body);
      print(response.statusCode);
      // 如果服务器返回了一个错误
      print('Failed to add pet');
    }
  }

  /// 示例：从后端拉取宠物数据
  Future<List<Pet>> fetchPetsFromBackend() async {
  final url = 'http://34.84.255.8:8080/pets/owner/:ownerName'; // 替换为你的API端点
  final response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    print('Raw response body: ${response.body}');

    // 清理 JSON 数据
    final cleanedJsonString = response.body.replaceAll(RegExp(r'[\x00-\x1F\x7F]'), '');
    final List<dynamic> jsonData = jsonDecode(cleanedJsonString);

    print('Decoded JSON data: $jsonData');
    return jsonData.map((data) => Pet.fromJson(data)).toList();
  } else {
    throw Exception('Failed to fetch pets');
  }
}
