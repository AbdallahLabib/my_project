import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_maps/features/email_and_password/presentation/screens/email_login_screen.dart';
import 'package:flutter_maps/features/maps/presentation/screens/map_screen.dart';

class LoginCheckerScreen extends StatelessWidget {
  const LoginCheckerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return const MapScreen();
          } else {
            return const EmailLoginScreen();
          }
        },
      ),
    );
  }
}
