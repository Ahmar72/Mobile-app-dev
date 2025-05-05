import 'package:flutter/material.dart';
import 'styles.dart';

class CardSection extends StatelessWidget {
  final Widget child;
  final  color;

  const CardSection({required this.child, super.key, this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: child,
    );
  }
}
