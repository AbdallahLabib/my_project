// ignore_for_file: prefer_const_constructors, avoid_print

import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_maps/core/constants/paths.dart';

class EmailRegisterScreen extends StatefulWidget {
  const EmailRegisterScreen({super.key});

  @override
  State<EmailRegisterScreen> createState() => _EmailRegisterScreenState();
}

class _EmailRegisterScreenState extends State<EmailRegisterScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPaswordController = TextEditingController();

  Future signUp() async {
    try {
      if (passwordConfirmed()) {
         FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
        ).then((value) => Navigator.of(context).pushNamed(mapScreen));
      }
      
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      log(e.toString());
    }
  }
  
  bool passwordConfirmed() {
    if (_confirmPaswordController.text.trim() ==
        _passwordController.text.trim()) {
      return true;
    } else {
      return false;
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _confirmPaswordController.dispose();
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
                'hello there!',
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
              SizedBox(height: 20),
              //TextField for Confirm password

              Padding(
                padding: EdgeInsets.symmetric(horizontal: 50),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.grey[200],
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.circular(10)),
                  child: TextField(
                    controller: _confirmPaswordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: '   Confirm Password',
                    ),
                  ),
                ),
              ),

              //sign in button

              GestureDetector(
                onTap: signUp,
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
                      'Sign Up',
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
                children: [
                  Text('already a member'),
                  SizedBox(
                    width: 10,
                  ),
                  GestureDetector(
                    onTap: () =>
                        Navigator.of(context).pushNamed(emailLoginScreen),
                    child: Text(
                      'Login now',
                      style: TextStyle(color: Colors.blue),
                    ),
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
