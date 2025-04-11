import 'package:flutter/material.dart';
import 'flashcard.dart';

class FlashcardScreen extends StatefulWidget {
  final List<Map<String, String>> cards;
  const FlashcardScreen({required this.cards, super.key});

  @override
  State<FlashcardScreen> createState() => _FlashcardScreenState();
}

class _FlashcardScreenState extends State<FlashcardScreen> {
  int _currentIndex = 0;
  int _score = 0;

  void _nextCard(bool isCorrect) {
    setState(() {
      if (isCorrect) _score += 1;
      if (_currentIndex < widget.cards.length - 1) {
        _currentIndex += 1;
      } else {
        _currentIndex = 0; // Loop back
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Score: $_score')),
      body: Column(
        children: [
          Flashcard(
            question: widget.cards[_currentIndex]['question']!,
            answer: widget.cards[_currentIndex]['answer']!,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () => _nextCard(false),
                child: const Text('Incorrect'),
              ),
              ElevatedButton(
                onPressed: () => _nextCard(true),
                child: const Text('Correct'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}