import 'package:flutter/material.dart';
import "package:aipet/Utility/typedefinition.dart";

class AddPetPage extends StatelessWidget {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _typeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Pet'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Pet Name'),
            ),
            TextField(
              controller: _typeController,
              decoration: InputDecoration(labelText: 'Pet Type'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Add pet to the list
                Navigator.pop(context);
              },
              child: Text('Add Pet'),
            ),
          ],
        ),
      ),
    );
  }
}