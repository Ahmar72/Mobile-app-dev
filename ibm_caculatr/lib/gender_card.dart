import 'package:flutter/material.dart';
import 'card_section.dart';
import 'styles.dart';

class GenderCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;


  const GenderCard({
    super.key,
    required this.icon,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: CardSection(
          color: isSelected ? activeCardColor : cardColor,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 60, color: Colors.white),
              const SizedBox(height: 10),
              Text(label, style: labelStyle),
            ],
          ),
        ),
      ),
    );
  }
}
