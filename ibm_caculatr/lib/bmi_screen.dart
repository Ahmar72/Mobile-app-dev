import 'package:flutter/material.dart';
import 'gender_card.dart';
import 'height_card.dart';
import 'value_card.dart';
import 'calculate_button.dart';
import 'styles.dart';

enum Gender { male, female }

class BMIScreen extends StatefulWidget {
  const BMIScreen({super.key});

  @override
  State<BMIScreen> createState() => _BMIScreenState();
}

class _BMIScreenState extends State<BMIScreen> {
  Gender? selectedGender;
  double height = 170;
  int weight = 60;
  int age = 20;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("BMI Calculator")),
      body: Column(
        children: [
          Expanded(
            child: Row(
              children: [
                GenderCard(
                  icon: Icons.male,
                  label: 'MALE',
                  isSelected: selectedGender == Gender.male,
                  onTap: () => setState(() => selectedGender = Gender.male),
                ),
                GenderCard(
                  icon: Icons.female,
                  label: 'FEMALE',
                  isSelected: selectedGender == Gender.female,
                  onTap: () => setState(() => selectedGender = Gender.female),
                ),
              ],
            ),
          ),
          Expanded(
            child: HeightCard(
              height: height,
              onChanged: (newHeight) =>
                  setState(() => height = newHeight),
            ),
          ),
          Expanded(
            child: Row(
              children: [
                ValueCard(
                  label: "WEIGHT",
                  value: weight,
                  onIncrement: () => setState(() => weight++),
                  onDecrement: () => setState(() {
                    if (weight > 1) weight--;
                  }),
                ),
                ValueCard(
                  label: "AGE",
                  value: age,
                  onIncrement: () => setState(() => age++),
                  onDecrement: () => setState(() {
                    if (age > 1) age--;
                  }),
                ),
              ],
            ),
          ),
          const CalculateButton(),
        ],
      ),
    );
  }
}
