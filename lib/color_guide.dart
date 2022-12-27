import 'package:flutter/material.dart';

class ColorGuide extends StatefulWidget {
  const ColorGuide({super.key});

  @override
  State<ColorGuide> createState() => _ColorGuideState();
}

class _ColorGuideState extends State<ColorGuide> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Row(
          children: [
            Container(
              height: 20.0,
              width: 20.0,
              decoration: BoxDecoration(
                color: const Color(0xFF1D1D1D),
                borderRadius: BorderRadius.circular(5.0),
                border: Border.all(
                  color: const Color(0xFF4E5E26),
                ),
              ),
            ),
            const SizedBox(
              width: 8.0,
            ),
            const Text(
              "Available",
              style: TextStyle(
                color: Colors.white,
                fontSize: 15.0,
              ),
            ),
          ],
        ),
        Row(
          children: [
            Container(
              height: 20.0,
              width: 20.0,
              decoration: BoxDecoration(
                color: const Color(0xFF4E5E26),
                borderRadius: BorderRadius.circular(5.0),
                border: Border.all(
                  color: const Color(0xFF4E5E26),
                ),
              ),
            ),
            const SizedBox(
              width: 8.0,
            ),
            const Text(
              "Reserved",
              style: TextStyle(
                color: Colors.white,
                fontSize: 15.0,
              ),
            ),
          ],
        ),
        Row(
          children: [
            Container(
              height: 20.0,
              width: 20.0,
              decoration: BoxDecoration(
                color: const Color(0xFFB6E93B),
                borderRadius: BorderRadius.circular(5.0),
                border: Border.all(
                  color: const Color(0xFFB6E93B),
                ),
              ),
            ),
            const SizedBox(
              width: 8.0,
            ),
            const Text(
              "Selected",
              style: TextStyle(
                color: Colors.white,
                fontSize: 15.0,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
