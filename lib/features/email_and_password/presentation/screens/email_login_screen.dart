// ignore_for_file: prefer_const_constructors, avoid_print

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_maps/core/constants/paths.dart';

class EmailLoginScreen extends StatefulWidget {
  const EmailLoginScreen({super.key});

  @override
  State<EmailLoginScreen> createState() => _EmailLoginScreenState();
}

class _EmailLoginScreenState extends State<EmailLoginScreen> {
  //Controllers for text field
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

   void signIn() async {
    try {
      UserCredential? user =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );
      if (user.user!.uid.isNotEmpty) {
        Navigator.of(context).pushNamed(mapScreen);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('no user found'),
          ),
        );
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              SizedBox(
                height: 50,
              ),
              // Icon
              Icon(
                Icons.android_rounded,
                size: 100,
              ),
              SizedBox(height: 75),
              //Text (hello)
              Text(
                'hello Again!',
                style: TextStyle(fontSize: 54, fontWeight: FontWeight.bold),
              ),

              SizedBox(height: 20),

              //Text (welcome)
              Text(
                'welcome back, you have been missed!',
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
              SizedBox(height: 20),

              //TextField for the email

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.grey[200],
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.circular(10)),
                  child: TextField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: '   Email',
                    ),
                  ),
                ),
              ),

              SizedBox(height: 20),

              //TextField for the password

              Padding(
                padding: EdgeInsets.symmetric(horizontal: 50),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.grey[200],
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.circular(10)),
                  child: TextField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: '   Password',
                    ),
                  ),
                ),
              ),

              //sign in button

              GestureDetector(
                onTap: signIn,
                //onTap: () => BlocProvider.of<EmailBloc>(context).add(SubmitEmailAndPasswordEvent()),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 130, vertical: 15),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.deepPurple),
                    child: Text(
                      'Sign In',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              //text not sign in ,register
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text('not a member?'),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    'Register now',
                    style: TextStyle(color: Colors.blue),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
