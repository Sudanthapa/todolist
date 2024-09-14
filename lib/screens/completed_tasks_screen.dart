import 'package:flutter/material.dart';
import '../models/task.dart'; // Import your Task model

class CompletedTasksScreen extends StatelessWidget {
  final List<Task> completedTasks;

  const CompletedTasksScreen({required this.completedTasks, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Completed Tasks'),
        backgroundColor: Colors.deepOrange,
      ),
      body: completedTasks.isEmpty
          ? Center(
              child: Text(
                'No completed tasks found',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: Colors.grey,
                      fontStyle: FontStyle.italic,
                    ),
              ),
            )
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListView.builder(
                itemCount: completedTasks.length,
                itemBuilder: (context, index) {
                  final task = completedTasks[index];
                  return Card(
                    elevation: 8,
                    margin: const EdgeInsets.only(bottom: 16.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Icon(
                                Icons.check_circle,
                                color: Colors.green,
                                size: 24,
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Text(
                                  task.title,
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleLarge
                                      ?.copyWith(
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Due Date: ${task.dueDate}',
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(
                                  color: Colors.grey[600],
                                ),
                          ),
                          const SizedBox(height: 8),
                          if (task.description.isNotEmpty)
                            Text(
                              task.description,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(
                                    color: Colors.grey[800],
                                  ),
                            ),
                          const SizedBox(height: 8),
                          if (task.priority.isNotEmpty)
                            Chip(
                              label: Text(
                                'Priority: ${task.priority}',
                                style: const TextStyle(color: Colors.white),
                              ),
                              backgroundColor: _getPriorityColor(task.priority),
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                            ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
    );
  }

  Color _getPriorityColor(String priority) {
    switch (priority) {
      case 'High':
        return Colors.red;
      case 'Medium':
        return Colors.orange;
      case 'Low':
        return Colors.green;
      default:
        return Colors.grey;
    }
  }
}
