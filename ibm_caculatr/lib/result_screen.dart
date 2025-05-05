import 'package:flutter/material.dart';
import 'app_colors.dart';

class ResultScreen extends StatelessWidget {
  const ResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        title: const Text("Result"),
      ),
      body: const Center(
        child: Text(
          "Your BMI Result",
          style: TextStyle(
            color: AppColors.whiteText,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
