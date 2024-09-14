import 'package:flutter/material.dart';
import '../models/task.dart'; // Import your Task model

class TaskListScreen extends StatefulWidget {
  final String title;
  final List<Task> tasks;
  final void Function(Task task) onTaskTap;

  const TaskListScreen({
    required this.title,
    required this.tasks,
    required this.onTaskTap,
    super.key,
    required Null Function(dynamic index) onCheckboxChanged,
  });

  @override
  // ignore: library_private_types_in_public_api
  _TaskListScreenState createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Colors.deepOrange,
        elevation: 0,
      ),
      body: ListView.builder(
        itemCount: widget.tasks.length,
        itemBuilder: (context, index) {
          final task = widget.tasks[index];
          return Card(
            elevation: 5,
            margin: const EdgeInsets.symmetric(vertical: 8),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: ListTile(
              contentPadding: const EdgeInsets.all(16),
              title: Text(
                task.title,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  decoration: task.isCompleted
                      ? TextDecoration.lineThrough
                      : TextDecoration.none, // Strike-through completed tasks
                ),
              ),
              subtitle: Text('Due: ${task.dueDate}'),
              trailing: Checkbox(
                value: task.isCompleted,
                onChanged: (bool? value) {
                  setState(() {
                    task.isCompleted = value ?? false;
                  });
                },
              ),
              onTap: () {
                widget.onTaskTap(task);
              },
            ),
          );
        },
      ),
    );
  }
}
