import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart'; // Add this import for email sending
import 'package:todolist/screens/add_task_screen.dart';
import 'package:todolist/screens/edit_task_screen.dart';
import 'package:todolist/screens/login_screen.dart';
import 'package:todolist/screens/setting_screen.dart';
import 'package:todolist/screens/task_history_screen.dart';
import '../models/task.dart'; // Import your Task model
import 'task_list_screen.dart'; // Import the TaskListScreen class

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Task> tasks = [
    Task(title: 'Task 1', dueDate: '2024-09-10', priority: 'High'),
    Task(title: 'Task 2', dueDate: '2024-09-11', priority: 'Medium'),
    // Add more tasks here
  ];

  List<Task> get activeTasks =>
      tasks.where((task) => !task.isCompleted).toList();
  List<Task> get completedTasks =>
      tasks.where((task) => task.isCompleted).toList();

  void _addTask(Task task) {
    setState(() {
      tasks.add(task);
    });
  }

  void _toggleTaskCompletion(int index) {
    setState(() {
      tasks[index].isCompleted = !tasks[index].isCompleted;
    });
  }

  // Function to handle logout action
  void _logout() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LoginScreen()),
    );
  }

  // Function to send tasks via email
  void _sendTasksToEmail() async {
    final email = Email(
      body: _generateEmailBody(),
      subject: 'Your To-Do List Tasks',
      recipients: [
        'example@example.com'
      ], // Replace with actual recipient email
      isHTML: false,
    );

    try {
      await FlutterEmailSender.send(email);
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Tasks sent to email!')),
      );
    } catch (error) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to send email: $error')),
      );
    }
  }

  // Helper method to generate email body
  String _generateEmailBody() {
    return tasks.map((task) {
      return 'Title: ${task.title}\nDue Date: ${task.dueDate}\nPriority: ${task.priority}\n\n';
    }).join();
  }

  // Function to handle category taps
  void _navigateToCategory(String category) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TaskListScreen(
          title: category,
          tasks: _getTasksForCategory(category),
          onTaskTap: (task) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => EditTaskScreen(task: task),
              ),
            );
          },
          onCheckboxChanged: (index) {
            _toggleTaskCompletion(index);
          },
        ),
      ),
    );
  }

  // Helper method to get tasks for a specific category
  List<Task> _getTasksForCategory(String category) {
    switch (category) {
      case 'Active Tasks':
        return activeTasks;
      case 'Completed Tasks':
        return completedTasks;
      case 'High Priority':
        return tasks.where((task) => task.priority == 'High').toList();
      case 'Medium Priority':
        return tasks.where((task) => task.priority == 'Medium').toList();
      case 'Due Soon':
        final now = DateTime.now();
        final nextWeek = now.add(const Duration(days: 7));
        return tasks.where((task) {
          final dueDate = DateTime.parse(task.dueDate);
          return dueDate.isAfter(now) && dueDate.isBefore(nextWeek);
        }).toList();
      default:
        return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        backgroundColor: Colors.deepOrange,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SettingsScreen(),
                ),
              );
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const DrawerHeader(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.orangeAccent, Colors.deepOrange],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Text(
                'To Do List',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              title: const Text('Home'),
              leading: const Icon(Icons.home),
              onTap: () {
                Navigator.pop(context); // Close the drawer when already on Home
              },
            ),
            ListTile(
              title: const Text('Add New Task'),
              leading: const Icon(Icons.add),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AddTaskScreen(),
                  ),
                );
              },
            ),
            ListTile(
              title: const Text('View Active Tasks'),
              leading: const Icon(Icons.task_alt),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TaskListScreen(
                      title: 'Active Tasks',
                      tasks: activeTasks,
                      onTaskTap: (task) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EditTaskScreen(task: task),
                          ),
                        );
                      },
                      onCheckboxChanged: (index) {
                        _toggleTaskCompletion(index);
                      },
                    ),
                  ),
                );
              },
            ),
            ListTile(
              title: const Text('Completed Tasks'),
              leading: const Icon(Icons.check_circle),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TaskListScreen(
                      title: 'Completed Tasks',
                      tasks: completedTasks,
                      onTaskTap: (task) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EditTaskScreen(task: task),
                          ),
                        );
                      },
                      onCheckboxChanged: (index) {
                        _toggleTaskCompletion(index);
                      },
                    ),
                  ),
                );
              },
            ),
            ListTile(
              title: const Text('Task History'),
              leading: const Icon(Icons.history),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TaskHistoryScreen(tasks: tasks),
                  ),
                );
              },
            ),
            ListTile(
              title: const Text('Send Tasks to Email'),
              leading: const Icon(Icons.email),
              onTap: _sendTasksToEmail,
            ),
            const Divider(),
            ListTile(
              title: const Text('Logout'),
              leading: const Icon(Icons.logout),
              onTap: _logout,
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                children: <Widget>[
                  _buildCategoryCard('Active Tasks', Colors.blueAccent),
                  _buildCategoryCard('Completed Tasks', Colors.greenAccent),
                  _buildCategoryCard('High Priority', Colors.redAccent),
                  _buildCategoryCard('Medium Priority', Colors.orangeAccent),
                  _buildCategoryCard('Due Soon', Colors.purpleAccent),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final newTask = await Navigator.push<Task>(
            context,
            MaterialPageRoute(builder: (context) => const AddTaskScreen()),
          );

          if (newTask != null) {
            _addTask(newTask);
          }
        },
        backgroundColor: Colors.deepOrange,
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildCategoryCard(String category, Color color) {
    return Card(
      elevation: 5,
      margin: const EdgeInsets.all(8.0),
      color: color, // Set the background color
      child: InkWell(
        onTap: () => _navigateToCategory(category),
        child: Center(
          child: Text(
            category,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white, // Set text color
            ),
          ),
        ),
      ),
    );
  }
}
