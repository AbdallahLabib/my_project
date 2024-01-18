// ignore_for_file: avoid_print
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_maps/core/constants/colors.dart';
import 'package:flutter_maps/core/constants/paths.dart';
import 'package:flutter_maps/features/authentication/presentation/bloc/phone_auth_bloc.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

// ignore: must_be_immutable
class OtpScreen extends StatelessWidget {
  OtpScreen({super.key, required this.phoneNumber});

  final String phoneNumber;
  late String otpCode;
  Widget _buildIntroText() {
    return Column(
      children: [
        const Text(
          'verify your phone number',
          style: TextStyle(
              color: Colors.black, fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 30,
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 5),
          child: RichText(
            text: TextSpan(
              text: 'Enter your 6 digits number sent to you',
              children: <TextSpan>[
                TextSpan(
                    text: phoneNumber,
                    style: const TextStyle(color: MyColors.blue)),
              ],
            ),
          ),
        )
      ],
    );
  }

  void _showProgressIndicator(BuildContext context) {
    AlertDialog alertDialog = const AlertDialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      content: Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation(Colors.black),
        ),
      ),
    );
    showDialog(
        barrierColor: Colors.white.withOpacity(0),
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return alertDialog;
        });
  }

  Widget _buildPinCodeFields(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(6),
      child: PinCodeTextField(
        appContext: context,
        autoFocus: true,
        cursorColor: Colors.black,
        length: 6,
        obscureText: false,
        animationType: AnimationType.scale,
        pinTheme: PinTheme(
          shape: PinCodeFieldShape.box,
          borderRadius: BorderRadius.circular(5),
          fieldHeight: 50,
          fieldWidth: 40,
          borderWidth: 1,
          activeColor: MyColors.blue,
          inactiveColor: MyColors.lightBlue,
          activeFillColor: MyColors.lightBlue,
          inactiveFillColor: Colors.white,
          selectedColor: MyColors.blue,
          selectedFillColor: Colors.white,
        ),
        animationDuration: const Duration(milliseconds: 300),
        backgroundColor: Colors.white,
        enableActiveFill: true,
        onCompleted: (submittedCode) {
          otpCode = submittedCode;
          print("Completed");
        },
        onChanged: (value) {
          print(value);
        },
      ),
    );
  }

  Widget _buildVerifyButton(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: ElevatedButton(
        onPressed: () {
          _showProgressIndicator(context);

          //sign in
          BlocProvider.of<PhoneAuthBloc>(context).add(SubmitOtpCodeEvent(otpCode: otpCode));
        },
        style: ElevatedButton.styleFrom(
            minimumSize: const Size(110, 50),
            backgroundColor: Colors.black,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(6))),
        child: const Text(
          'verify',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
          ),
        ),
      ),
    );
  }

  Widget _buildPhoneVerificationBloc() {
    return BlocListener<PhoneAuthBloc, PhoneAuthState>(
      listenWhen: ((previous, current) {
        return previous != current;
      }),
      listener: (context, state) {
        if (state is LoadingState) {
          _showProgressIndicator(context);
        }
        if (state is OtpSubmittedState) {
          Navigator.pop(context);
          Navigator.of(context).pushReplacementNamed(mapScreen);
        }

        if (state is ErrorOccuredState) {
          Navigator.pop(context);
          String errorMsg = (state).errorMsg;
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(errorMsg),
            backgroundColor: Colors.black,
            duration: const Duration(seconds: 3),
          ));
        }
      },
      child: Container(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          child: Column(children: [
            _buildIntroText(),
            const SizedBox(
              height: 88,
            ),
            _buildPinCodeFields(context),
            const SizedBox(
              height: 60,
            ),
            _buildVerifyButton(context),
            _buildPhoneVerificationBloc(),
          ]),
        ),
      ),
    );
  }
}
