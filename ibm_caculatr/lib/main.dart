import 'package:flutter/material.dart';

void main() => runApp(const BMICalculator());

class BMICalculator extends StatelessWidget {
  const BMICalculator({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const BMIScreen(),
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Colors.black,
        primaryColor: Colors.red,
      ),
    );
  }
}

class BMIScreen extends StatelessWidget {
  const BMIScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("BMI Calculator")),
      body: SafeArea(
        child: Column(
          children: const [
            Expanded(
              child: Row(
                children: [
                  GenderCard(icon: Icons.male, label: 'MALE'),
                  GenderCard(icon: Icons.female, label: 'FEMALE'),
                ],
              ),
            ),
            Expanded(
              child: HeightCard(),
            ),
            Expanded(
              child: Row(
                children: [
                  ValueCard(label: "WEIGHT", value: 60),
                  ValueCard(label: "AGE", value: 20),
                ],
              ),
            ),
            CalculateButton(),
          ],
        ),
      ),
    );
  }
}

// Reusable constants
const cardColor = Color(0xFF1D1E33);
const labelStyle = TextStyle(color: Colors.white);
const valueStyle = TextStyle(
  color: Colors.white,
  fontSize: 30,
  fontWeight: FontWeight.bold,
);

class GenderCard extends StatelessWidget {
  final IconData icon;
  final String label;

  const GenderCard({required this.icon, required this.label, super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: CardSection(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 60, color: Colors.white),
            const SizedBox(height: 10),
            Text(label, style: labelStyle),
          ],
        ),
      ),
    );
  }
}

class HeightCard extends StatelessWidget {
  const HeightCard({super.key});

  @override
  Widget build(BuildContext context) {
    return CardSection(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text("HEIGHT", style: labelStyle),
          const Text("147 cm", style: valueStyle),
          Slider(
            value: 147.0,
            min: 100.0,
            max: 220.0,
            divisions: 120,
            label: '147 cm',
            onChanged: (val) {},
            activeColor: Colors.red,
          ),
        ],
      ),
    );
  }
}

class ValueCard extends StatelessWidget {
  final String label;
  final int value;

  const ValueCard({required this.label, required this.value, super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: CardSection(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(label, style: labelStyle),
            Text('$value', style: valueStyle),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                RoundIcon(icon: Icons.remove),
                SizedBox(width: 10),
                RoundIcon(icon: Icons.add),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class RoundIcon extends StatelessWidget {
  final IconData icon;

  const RoundIcon({required this.icon, super.key});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: Colors.grey[800],
      child: Icon(icon, color: Colors.white),
    );
  }
}

class CalculateButton extends StatelessWidget {
  const CalculateButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.red,
      height: 60,
      width: double.infinity,
      child: const Center(
        child: Text(
          "CALCULATE",
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}

class CardSection extends StatelessWidget {
  final Widget child;

  const CardSection({required this.child, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: child,
    );
  }
}
