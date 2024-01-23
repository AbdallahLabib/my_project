import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[800],
      ),
      body: Column(
        children: [
          const SizedBox(height: 100),
          Center(
            child: ElevatedButton(
              onPressed: () async {
                FirebaseAuth.instance.signOut();
                // await phoneAuthBloc.signOut();
                // Navigator.of(context).pushReplacementNamed(loginScreen);
              },
              style: ElevatedButton.styleFrom(
                  minimumSize: const Size(110, 50),
                  backgroundColor: const Color.fromARGB(255, 2, 2, 2),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6))),
              child: const Text(
                'Sign Out',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
