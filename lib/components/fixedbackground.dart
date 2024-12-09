import 'package:flutter/material.dart';


class FixedBackground extends StatelessWidget {
  const FixedBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Background image
        Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("images/House.jfif"), // Background image
              fit: BoxFit.cover,
            ),
          ),
        ),
      
        Container(
          color: const Color(0xFF052659).withOpacity(0.5), // Overlay color and opacity
        ),
      ],
    );
  }
}