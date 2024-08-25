import 'package:flutter/material.dart';
import 'package:aipet/Utility/typedefinition.dart'; // Import the typedefinition.dart file
import 'package:aipet/PetPage/add_pet_page.dart'; // Import the http.dart file
class PetDetailPage extends StatefulWidget {
  final Pet pet;

  const PetDetailPage({super.key, required this.pet});

  @override
  _PetDetailPageState createState() => _PetDetailPageState();
}

class _PetDetailPageState extends State<PetDetailPage> {
  final List<Reminder> reminders = [];
  final TextEditingController _descriptionController = TextEditingController();
  TimeOfDay? _selectedTime;

  void _addReminder() {
    if (_descriptionController.text.isEmpty || _selectedTime == null) {
      return;
    }

    final reminder = Reminder(
      description: _descriptionController.text,
      time: _selectedTime!,
    );
    setState(() {
      reminders.add(reminder);
    });
    _descriptionController.clear();
    _selectedTime = null;
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null && picked != _selectedTime) {
      setState(() {
        _selectedTime = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.pet.name),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: reminders.length,
              itemBuilder: (context, index) {
                final reminder = reminders[index];
                return ListTile(
                  title: Text(reminder.description),
                  subtitle: Text(reminder.time.format(context)),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _descriptionController,
                    decoration: const InputDecoration(
                      hintText: 'Enter reminder description',
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.access_time),
                  onPressed: () => _selectTime(context),
                ),
                IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: _addReminder,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}