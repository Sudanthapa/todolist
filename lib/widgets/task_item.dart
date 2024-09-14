import 'package:flutter/material.dart';

class TaskItem extends StatelessWidget {
  final String title;
  final String dueDate;
  final bool isCompleted;
  final bool isRecurring;
  final String? recurrenceFrequency;
  final ValueChanged<bool?>
      onCheckboxChanged; // Updated to accept the correct function type
  final VoidCallback onTap;

  const TaskItem({
    super.key,
    required this.title,
    required this.dueDate,
    required this.isCompleted,
    required this.isRecurring,
    required this.recurrenceFrequency,
    required this.onCheckboxChanged,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        title,
        style: TextStyle(
          decoration:
              isCompleted ? TextDecoration.lineThrough : TextDecoration.none,
        ),
      ),
      subtitle: Text('Due: $dueDate'),
      trailing: Checkbox(
        value: isCompleted,
        onChanged: onCheckboxChanged, // This links to the toggle function
      ),
      onTap: onTap,
    );
  }
}
