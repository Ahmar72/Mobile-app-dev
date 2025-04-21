import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const MultiplicationTablesApp());
}

class MultiplicationTablesApp extends StatelessWidget {
  const MultiplicationTablesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Multiplication Tables',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Roboto',
        useMaterial3: true,
      ),
      home: const HomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}