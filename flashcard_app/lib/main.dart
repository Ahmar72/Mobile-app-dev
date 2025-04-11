import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'new_card_screen.dart';

void main() => runApp(const FlashcardApp());

class FlashcardApp extends StatelessWidget {
  const FlashcardApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flashcard App',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: HomeScreen(),
      routes: {
        '/new-card': (context) => const NewCardScreen(),
      },
    );
  }
}