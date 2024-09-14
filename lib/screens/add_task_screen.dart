import 'package:flutter/material.dart';
import '../models/task.dart'; // Import your Task model

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _AddTaskScreenState createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _dueDateController = TextEditingController();
  bool _isRecurring = false; // To track if the task is recurring
  String? _recurrenceFrequency; // To store recurrence frequency
  String? _priority; // To store priority

  final List<String> _recurrenceOptions = [
    'Daily',
    'Weekly',
    'Monthly',
  ]; // Recurrence options

  final List<String> _priorityOptions = [
    'Low',
    'Medium',
    'High',
  ]; // Priority options

  Future<void> _selectDate(BuildContext context) async {
    final DateTime now = DateTime.now();
    final DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: now,
      lastDate: DateTime(2101),
    );

    if (selectedDate != null) {
      setState(() {
        _dueDateController.text = '${selectedDate.toLocal()}'.split(' ')[0];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New Task'),
        backgroundColor: Colors.deepOrange,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Create a New Task',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.deepOrange,
                    ),
              ),
              const SizedBox(height: 24),
              TextField(
                controller: _titleController,
                decoration: InputDecoration(
                  labelText: 'Task Title',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  prefixIcon: const Icon(Icons.title, color: Colors.deepOrange),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _dueDateController,
                decoration: InputDecoration(
                  labelText: 'Due Date',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.calendar_today,
                        color: Colors.deepOrange),
                    onPressed: () => _selectDate(context),
                  ),
                ),
                readOnly: true, // Make it read-only to prevent manual input
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  labelText: 'Priority',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                value: _priority,
                onChanged: (String? newValue) {
                  setState(() {
                    _priority = newValue;
                  });
                },
                items: _priorityOptions.map((String option) {
                  return DropdownMenuItem<String>(
                    value: option,
                    child: Text(option),
                  );
                }).toList(),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Is this a recurring task?',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: Colors.deepOrange,
                        ),
                  ),
                  Switch(
                    value: _isRecurring,
                    onChanged: (value) {
                      setState(() {
                        _isRecurring = value;
                        if (!_isRecurring) {
                          _recurrenceFrequency =
                              null; // Reset frequency if not recurring
                        }
                      });
                    },
                  ),
                ],
              ),
              if (_isRecurring)
                Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                      labelText: 'Recurrence Frequency',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    value: _recurrenceFrequency,
                    onChanged: (String? newValue) {
                      setState(() {
                        _recurrenceFrequency = newValue;
                      });
                    },
                    items: _recurrenceOptions.map((String option) {
                      return DropdownMenuItem<String>(
                        value: option,
                        child: Text(option),
                      );
                    }).toList(),
                  ),
                ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () {
                  if (_titleController.text.isNotEmpty &&
                      _dueDateController.text.isNotEmpty &&
                      _priority != null) {
                    final newTask = Task(
                      title: _titleController.text,
                      dueDate: _dueDateController.text,
                      isCompleted: false,
                      isRecurring: _isRecurring,
                      recurrenceFrequency: _recurrenceFrequency,
                      priority: _priority!,
                    );
                    Navigator.pop(context, newTask); // Return the new task
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepOrange,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                child: const Text(
                  'Add Task',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
