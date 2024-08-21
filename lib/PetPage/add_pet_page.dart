import 'package:flutter/material.dart';

class AddPetPage extends StatelessWidget {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _typeController = TextEditingController();

  AddPetPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Pet'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Pet Name'),
            ),
            TextField(
              controller: _typeController,
              decoration: const InputDecoration(labelText: 'Pet Type'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Add pet to the list
                Navigator.pop(context);
              },
              child: const Text('Add Pet'),
            ),
          ],
        ),
      ),
    );
  }
}