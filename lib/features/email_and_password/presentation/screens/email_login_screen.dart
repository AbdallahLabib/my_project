// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class EmailLoginScreen extends StatefulWidget {
  const EmailLoginScreen({super.key});

  @override
  State<EmailLoginScreen> createState() => _EmailLoginScreenState();
}

class _EmailLoginScreenState extends State<EmailLoginScreen> {

  //Controllers for text field
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              SizedBox(height: 50,),
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
        
              Padding(
                padding: const EdgeInsets.all(20),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 130, vertical: 15),
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
