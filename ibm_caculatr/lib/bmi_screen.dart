import 'package:flutter/material.dart';
import 'gender_card.dart';
import 'card_section.dart';
import 'app_colors.dart';
import 'styles.dart';
import 'result_screen.dart';

enum Gender { male, female }

class BMIScreen extends StatefulWidget {
  const BMIScreen({super.key});

  @override
  State<BMIScreen> createState() => _BMIScreenState();
}

class _BMIScreenState extends State<BMIScreen> {
  Gender? selectedGender;
  double height = 147.0;
  int weight = 60;
  int age = 20;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text("BMI Calculator"),
        backgroundColor: AppColors.background,
      ),
      body: SafeArea(
        child: Column(
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
              child: CardSection(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("HEIGHT", style: labelStyle),
                    Text("${height.round()} cm", style: numberStyle),
                    Slider(
                      value: height,
                      min: 100.0,
                      max: 220.0,
                      divisions: 120,
                      label: "${height.round()} cm",
                      onChanged: (val) => setState(() => height = val),
                      activeColor: AppColors.sliderThumb,
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Row(
                children: [
                  buildValueCard("WEIGHT", weight, () {
                    setState(() => weight--);
                  }, () {
                    setState(() => weight++);
                  }),
                  buildValueCard("AGE", age, () {
                    setState(() => age--);
                  }, () {
                    setState(() => age++);
                  }),
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                // Navigate to result screen
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ResultScreen()),
                );
              },
              child: Container(
                color: AppColors.buttonColor,
                height: 60,
                width: double.infinity,
                child: const Center(
                  child: Text("CALCULATE", style: TextStyle(color: Colors.white, fontSize: 18)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildValueCard(String label, int value, VoidCallback onDecrease, VoidCallback onIncrease) {
    return Expanded(
      child: CardSection(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(label, style: labelStyle),
            Text('$value', style: numberStyle),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                buildRoundIconButton(Icons.remove, onDecrease),
                const SizedBox(width: 10),
                buildRoundIconButton(Icons.add, onIncrease),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildRoundIconButton(IconData icon, VoidCallback onPressed) {
    return GestureDetector(
      onTap: onPressed,
      child: CircleAvatar(
        backgroundColor: AppColors.greyButton,
        child: Icon(icon, color: Colors.white),
      ),
    );
  }
}
