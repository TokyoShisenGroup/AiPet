import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import "package:aipet/PostPage/create_post_page.dart" as create_post_page;
class PostListPage extends StatefulWidget {
  @override
  _PostListPageState createState() => _PostListPageState();
}

class _PostListPageState extends State<PostListPage> {
  Future<List<Map<String, dynamic>>> fetchPosts() async {
    // 模拟假数据
    await Future.delayed(Duration(seconds: 1)); // 模拟网络延迟
    List<Map<String, dynamic>> fakeData = [
      {
        'title': 'First Post',
        'authorName': 'Author 1',
        'content': 'This is the content of the first post.',
      },
      {
        'title': 'Second Post',
        'authorName': 'Author 2',
        'content': 'This is the content of the second post.',
      },
      {
        'title': 'Third Post',
        'authorName': 'Author 3',
        'content': 'This is the content of the third post.',
      },
    ];
    return fakeData;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Posts'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => create_post_page.CreatePostPage()),
              );
            },
          ),
        ],
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: fetchPosts(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No posts found'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final post = snapshot.data![index];
                return ListTile(
                  title: Text(post['title']),
                  subtitle: Text(post['authorName']),
                  onTap: () {
                    // Navigate to post detail page if needed
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}