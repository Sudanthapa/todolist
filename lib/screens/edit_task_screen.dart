import 'package:flutter/material.dart';
import '../models/task.dart';

class EditTaskScreen extends StatefulWidget {
  final Task task;

  const EditTaskScreen({super.key, required this.task});

  @override
  // ignore: library_private_types_in_public_api
  _EditTaskScreenState createState() => _EditTaskScreenState();
}

class _EditTaskScreenState extends State<EditTaskScreen> {
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;
  late TextEditingController _dueDateController;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.task.title);
    _descriptionController =
        TextEditingController(text: widget.task.description);
    _dueDateController = TextEditingController(text: widget.task.dueDate);
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime now = DateTime.now();
    final DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: now, // Prevent past dates from being selected
      lastDate: DateTime(2101),
    );

    if (selectedDate != null) {
      setState(() {
        _dueDateController.text = '${selectedDate.toLocal()}'.split(' ')[0];
      });
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _dueDateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Task'),
        backgroundColor: Colors.deepOrange,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Edit your task',
                style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 20),
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(labelText: 'Title'),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _descriptionController,
              decoration: const InputDecoration(labelText: 'Description'),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _dueDateController,
              decoration: InputDecoration(
                labelText: 'Due Date',
                suffixIcon: IconButton(
                  icon: const Icon(Icons.calendar_today),
                  onPressed: () => _selectDate(context),
                ),
              ),
              readOnly: true, // Prevent manual input
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              value: widget.task.priority,
              items: <String>['High', 'Medium', 'Low'].map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (value) {
                // Handle priority change
              },
              decoration: const InputDecoration(labelText: 'Priority'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Save task logic
                Navigator.pop(context);
              },
              child: const Text('Save Changes'),
            ),
          ],
        ),
      ),
    );
  }
}
