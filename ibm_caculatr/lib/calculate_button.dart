import 'package:flutter/material.dart';

class CalculateButton extends StatelessWidget {
  const CalculateButton({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Implement BMI calculation and navigation here.
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("BMI Calculated (not yet implemented)")),
        );
      },
      child: Container(
        color: Colors.red,
        height: 60,
        width: double.infinity,
        child: const Center(
          child: Text(
            "CALCULATE",
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
        ),
      ),
    );
  }
}
