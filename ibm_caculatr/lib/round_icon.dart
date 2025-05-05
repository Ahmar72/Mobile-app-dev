import 'package:flutter/material.dart';

class RoundIcon extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;

  const RoundIcon({super.key, required this.icon, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: CircleAvatar(
        backgroundColor: Colors.grey[800],
        child: Icon(icon, color: Colors.white),
      ),
    );
  }
}
