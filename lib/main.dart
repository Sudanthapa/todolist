import 'package:flutter/material.dart';
import 'package:todolist/screens/login_screen.dart';

import 'screens/signup_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TODO List',
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
      ),
      home: const LoginScreen(),
      routes: {
        '/login': (context) =>
            const SignupScreen(), // Define the login screen route
      },
    );
  }
}
