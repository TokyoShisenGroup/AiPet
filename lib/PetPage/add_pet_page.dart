import 'package:flutter/material.dart';
class AddPetPage extends StatelessWidget {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _typeController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _birthdayController = TextEditingController();


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
            TextField(
              controller: _weightController,
              decoration: const InputDecoration(labelText: 'Pet Weight'),
            ),
            DateSelector(
              controller: _birthdayController,
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

class DateSelector extends StatefulWidget {
  final TextEditingController controller;
  DateSelector({required this.controller});
  @override
  _DateSelectorState createState() => _DateSelectorState();
}

class _DateSelectorState extends State<DateSelector> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      readOnly: true,
      decoration: InputDecoration(
        labelText: 'Select Date',
        suffixIcon: Icon(Icons.calendar_today),
      ),
      onTap: () async {
        DateTime? pickedDate = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(1900),
          lastDate: DateTime(2100),
        );

        if (pickedDate != null) {
          setState(() {
            widget.controller.text = "${pickedDate.toLocal()}".split(' ')[0];
          });
        }
      },
    );
  }
}