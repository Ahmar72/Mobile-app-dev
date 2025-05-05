import 'package:flutter/material.dart';
import 'card_section.dart';
import 'styles.dart';

class HeightCard extends StatelessWidget {
  final double height;
  final ValueChanged<double> onChanged;

  const HeightCard({
    super.key,
    required this.height,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return CardSection(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text("HEIGHT", style: labelStyle),
          Text("${height.round()} cm", style: valueStyle),
          Slider(
            value: height,
            min: 100,
            max: 220,
            divisions: 120,
            label: "${height.round()}",
            onChanged: onChanged,
            activeColor: Colors.red,
          ),
        ],
      ),
    );
  }
}
