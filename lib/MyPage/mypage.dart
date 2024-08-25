import 'package:aipet/MyPage/settingpage.dart';
import 'package:aipet/PetPage/pet_management_page.dart';
import 'package:aipet/Utility/typedefinition.dart';
import 'package:flutter/material.dart';

class MyPage extends StatefulWidget {
  final User user;
  final VoidCallback onLogout;

  const MyPage({required this.user, required this.onLogout, Key? key})
      : super(key: key);

  @override
  _MyPageState createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  late User _user;

  @override
  void initState() {
    super.initState();
    _user = widget.user;
  }

  void _updateUser(User updatedUser) {
    setState(() {
      _user = updatedUser;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Page'),
        automaticallyImplyLeading: false,
        actions: [],
        leading: null,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            CircleAvatar(
              backgroundImage: NetworkImage(_user.avatarUrl),
              radius: 50,
            ),
            const SizedBox(height: 20),
            Text(
              _user.name,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              _user.email,
              style: const TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SettingsPage(
                      user: _user,
                      onUpdateUser: _updateUser,
                    ),
                  ),
                );
              },
              child: const Text('Settings'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PetManagementPage()),
                );
              },
              child: const Text('Pet Management'),
            ),
          ],
        ),
      ),
    );
  }
}
