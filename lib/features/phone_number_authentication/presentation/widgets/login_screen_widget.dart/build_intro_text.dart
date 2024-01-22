import 'package:flutter/material.dart';

class BuildIntroText extends StatelessWidget {
  const BuildIntroText({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          'what is your phone number',
          style: TextStyle(
              color: Colors.black, fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 30,
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 2),
          child: const Text(
            'please enter your phone number to verify your account',
            style: TextStyle(color: Colors.black, fontSize: 18),
          ),
        ),
      ],
    );
  }
}
