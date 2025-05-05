import 'package:flutter/material.dart';
import 'app_colors.dart';

class CardSection extends StatelessWidget {
  final Widget child;
  final Color color;

  const CardSection({
    super.key,
    required this.child,
    this.color = AppColors.cardDefault,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10),
      ),
      child: child,
    );
  }
}
