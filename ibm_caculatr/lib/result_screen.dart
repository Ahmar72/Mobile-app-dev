import 'package:flutter/material.dart';
import 'app_colors.dart';

class ResultScreen extends StatelessWidget {
  final double bmi;

  const ResultScreen({super.key, required this.bmi});

  String getBMICategory(double bmi) {
    if (bmi < 18.5) return "Underweight";
    if (bmi < 25) return "Normal";
    if (bmi < 30) return "Overweight";
    return "Obese";
  }

  @override
  Widget build(BuildContext context) {
    final String bmiResult = bmi.toStringAsFixed(1);
    final String category = getBMICategory(bmi);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        title: const Text("Your Result"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const Text("RESULT", style: TextStyle(fontSize: 30, color: Colors.white)),
          Text(
            "BMI: $bmiResult",
            style: const TextStyle(fontSize: 50, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          Text(
            category,
            style: const TextStyle(fontSize: 24, color: Colors.white70),
          ),
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              color: AppColors.buttonColor,
              height: 60,
              width: double.infinity,
              child: const Center(
                child: Text("RE-CALCULATE", style: TextStyle(color: Colors.white, fontSize: 18)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
