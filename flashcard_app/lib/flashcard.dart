import 'package:flutter/material.dart';

class Flashcard extends StatefulWidget {
  final String question;
  final String answer;
  const Flashcard({required this.question, required this.answer, super.key});

  @override
  State<Flashcard> createState() => _FlashcardState();
}

class _FlashcardState extends State<Flashcard> with SingleTickerProviderStateMixin {
  bool _showAnswer = false;
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _animation = Tween<double>(begin: 0, end: 1).animate(_controller);
  }

  void _toggleCard() {
    setState(() {
      _showAnswer = !_showAnswer;
      if (_controller.isCompleted) {
        _controller.reverse();
      } else {
        _controller.forward();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _toggleCard,
      child: AnimatedBuilder(
        animation: _animation,
        builder: (context, child) {
          return Transform(
            transform: Matrix4.identity()
              ..setEntry(3, 2, 0.002)
              ..rotateY(_animation.value * 3.14159),
            alignment: Alignment.center,
            child: Container(
              width: 300,
              height: 200,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: _showAnswer ? Colors.blue[100] : Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10)],
              ),
              child: Center(
                child: Text(
                  _showAnswer ? widget.answer : widget.question,
                  style: const TextStyle(fontSize: 20),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}