import 'package:flutter/material.dart';
import 'card_section.dart';
import 'round_icon.dart';
import 'styles.dart';

class ValueCard extends StatelessWidget {
  final String label;
  final int value;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;

  const ValueCard({
    super.key,
    required this.label,
    required this.value,
    required this.onIncrement,
    required this.onDecrement,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: CardSection(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(label, style: labelStyle),
            Text('$value', style: valueStyle),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                RoundIcon(icon: Icons.remove, onPressed: onDecrement),
                const SizedBox(width: 10),
                RoundIcon(icon: Icons.add, onPressed: onIncrement),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
