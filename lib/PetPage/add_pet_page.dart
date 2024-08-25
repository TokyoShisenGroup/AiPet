import 'package:flutter/material.dart';
import 'package:aipet/Utility/typedefinition.dart';
import 'package:aipet/PetPage/pet_management_page.dart';
class AddPetPage extends StatelessWidget {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _typeController = TextEditingController();
  final TextEditingController _kindController = TextEditingController();
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
            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Pet Name'),
              validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter name';
                  }
                  return null;
                },
            ),
            TextFormField(
                controller: _typeController,
                decoration: const InputDecoration(labelText: 'Type'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a type';
                  }
                  return null;
                },
            ),
            TextFormField(
                controller: _kindController,
                decoration: const InputDecoration(labelText: 'Kind'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter kind';
                  }
                  return null;
                },
              ),
            TextFormField(
                controller: _weightController,
                decoration: const InputDecoration(labelText: 'Weight'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a weight';
                  }
                  return null;
                },
              ),
            DateSelector(
              controller: _birthdayController,

            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                final String name = _nameController.text;
                final String type = _typeController.text;
                final String kind = _kindController.text;
                final double weight = double.parse(_weightController.text);
                final DateTime birthday = DateTime.parse(_birthdayController.text).toUtc().add(Duration(hours: 9));

                final Pet newPet = Pet(
                  name: name,
                  type: type,
                  kind: kind,
                  weight: weight,
                  birthday: birthday,
                );
                // Add pet to the list
                Navigator.pop(context, newPet);
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
        labelText: 'Birthday',
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