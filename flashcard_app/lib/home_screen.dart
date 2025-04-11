import 'package:flashcard_app/new_card_screen.dart';
import 'package:flutter/material.dart';
import 'flashcard_screen.dart';

class HomeScreen extends StatelessWidget {
  final Map<String, List<Map<String, String>>> decks = {
    'Flutter': [
      {'question': 'What is a Widget?', 'answer': 'A UI component.'},
      {'question': 'What is BuildContext?', 'answer': 'Location in the tree.'},
    ],
    'Dart': [
      {'question': 'Is Dart null-safe?', 'answer': 'Yes!'},
    ],
  };

  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Flashcard Decks')),
      body: ListView.builder(
        itemCount: decks.length,
        itemBuilder: (context, index) {
          String deckName = decks.keys.elementAt(index);
          return ListTile(
            title: Text(deckName),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => FlashcardScreen(
                  cards: decks[deckName]!,
                ),
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const NewCardScreen()),
        ),
        child: const Icon(Icons.add),
      ),
    );
  }
}