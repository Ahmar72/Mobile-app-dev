import 'package:flutter/material.dart';
import 'card_section.dart';
import 'app_colors.dart';
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
          color: isSelected ? AppColors.cardActive : AppColors.cardDefault,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 60, color: AppColors.whiteText),
              const SizedBox(height: 10),
              Text(label, style: labelStyle),
            ],
          ),
        ),
      ),
    );
  }
}
