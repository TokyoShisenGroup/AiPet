import 'package:flutter/material.dart';
import 'package:aipet/Utility/typedefinition.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SettingsPage extends StatefulWidget {
  final User user;
  final Function(User) onUpdateUser;

  const SettingsPage({
    required this.user,
    required this.onUpdateUser,
    super.key,
  });

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _nameController.text = widget.user.name;
    _emailController.text = widget.user.email;
  }

  Future<void> _updateUser() async {
    if (_newPasswordController.text.isNotEmpty) {
      final Map<String, String> requestData = {
        'UserName': _nameController.text,
        'PassWord': _newPasswordController.text,
        'Avatar': widget.user.avatarUrl,
        // Include other fields as necessary
      };

      try {
        // final response = await http.put(
        //   Uri.parse(
        //       'https://34.84.255.8:8081/users/${widget.user.name}'), // Use the actual endpoint
        //   headers: {
        //     'Content-Type': 'application/json',
        //   },
        //   body: jsonEncode(requestData),
        // );

        // if (response.statusCode == 200) {
        final updatedUser = User(
          name: _nameController.text,
          email: _emailController.text,
          avatarUrl: widget.user.avatarUrl,
        );

        widget.onUpdateUser(updatedUser);

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Changes saved successfully')),
        );

        Navigator.pop(context);
        // } else {
        //   ScaffoldMessenger.of(context).showSnackBar(
        //     SnackBar(content: Text('Failed to save changes: ${response.body}')),
        //   );
        // }
      } catch (error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('An error occurred: $error')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('New password cannot be empty')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Name'),
            ),
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: _newPasswordController,
              decoration: const InputDecoration(labelText: 'New Password'),
              obscureText: true,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _updateUser,
              child: const Text('Save Changes'),
            ),
          ],
        ),
      ),
    );
  }
}
