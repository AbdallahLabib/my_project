import 'package:flutter/material.dart';
import 'package:flutter_maps/core/constants/paths.dart';

class BuildLoginByEmailButton extends StatelessWidget {
  const BuildLoginByEmailButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: ElevatedButton(
        onPressed: () {
          Navigator.of(context).pushNamed(emailLoginScreen);
        },
        style: ElevatedButton.styleFrom(
            backgroundColor: Colors.grey[600],
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
        child: const Text(
          'Login by email',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
          ),
        ),
      ),
    );
  }
}
