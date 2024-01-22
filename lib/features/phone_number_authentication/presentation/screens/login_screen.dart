import 'package:flutter/material.dart';
import 'package:flutter_maps/features/phone_number_authentication/presentation/widgets/login_screen_widget.dart/build_by_email_button.dart';
import 'package:flutter_maps/features/phone_number_authentication/presentation/widgets/login_screen_widget.dart/build_form_field.dart';
import 'package:flutter_maps/features/phone_number_authentication/presentation/widgets/login_screen_widget.dart/build_intro_text.dart';
import 'package:flutter_maps/features/phone_number_authentication/presentation/widgets/login_screen_widget.dart/build_next_button.dart';

// ignore: must_be_immutable
class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final phoneFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Form(
          key: phoneFormKey,
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 32, vertical: 88),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const BuildIntroText(),
                  const SizedBox(
                    height: 110,
                  ),
                  const BuildFormField(),
                  const SizedBox(height: 60),
                  BuildNextButton(
                    phoneFormKey: phoneFormKey,
                    phoneNumber: '',
                  ),
                  const SizedBox(height: 120,),
                  const BuildLoginByEmailButton()
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
