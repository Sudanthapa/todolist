import 'package:flutter/material.dart';
import '../models/task.dart'; // Import your Task model

class TaskHistoryScreen extends StatelessWidget {
  final List<Task> tasks;

  const TaskHistoryScreen({required this.tasks, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Task History'),
        backgroundColor: Colors.deepOrange,
      ),
      body: tasks.isEmpty
          ? Center(
              child: Text(
                'No tasks found',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: Colors.grey,
                      fontStyle: FontStyle.italic,
                    ),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16.0),
              itemCount: tasks.length,
              itemBuilder: (context, index) {
                final task = tasks[index];
                return Card(
                  elevation: 8,
                  margin: const EdgeInsets.only(bottom: 16.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: InkWell(
                    onTap: () {
                      // Add your onTap logic here, if needed
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(
                                task.isCompleted
                                    ? Icons.check_circle
                                    : Icons.radio_button_unchecked,
                                color: task.isCompleted
                                    ? Colors.green
                                    : Colors.red,
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
                          // Check if task.description is not null and not empty
                          if (task.description != null &&
                              task.description!.isNotEmpty)
                            Text(
                              task.description!,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(
                                    color: Colors.grey[800],
                                  ),
                            ),
                          const SizedBox(height: 8),
                          // Check if task.priority is not null and not empty
                          if (task.priority != null &&
                              task.priority!.isNotEmpty)
                            Chip(
                              label: Text(
                                'Priority: ${task.priority!}',
                                style: const TextStyle(color: Colors.white),
                              ),
                              backgroundColor:
                                  _getPriorityColor(task.priority!),
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                            ),
                        ],
                      ),
                    ),
                  ),
                );
              },
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
