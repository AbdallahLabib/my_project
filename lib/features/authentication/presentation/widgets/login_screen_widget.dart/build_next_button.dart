// ignore_for_file: public_member_api_docs, sort_constructors_first, avoid_print
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';import 'package:flutter_maps/core/widgets/show_progress_indicator.dart';
import 'package:flutter_maps/features/authentication/presentation/bloc/phone_auth_bloc.dart';

class BuildNextButton extends StatelessWidget {
  final String phoneNumber ;
  final GlobalKey<FormState> phoneFormKey;
   const BuildNextButton({Key? key, required this.phoneFormKey, required this.phoneNumber, })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<PhoneAuthBloc, PhoneAuthState>(
      listenWhen: ((previous, current) {
        return previous != current;
      }),
      listener: (context, state) {
        if (state is LoadingState) {
          const ShowProgressIndicator();
        }
        if (state is PhoneNumberSubmittedState) {
          // Navigator.pop(context);
          // Navigator.of(context).pushNamed(otpScreen, arguments: phoneNumber);
        }

        if (state is ErrorOccuredState) {
          // Navigator.pop(context);
          String errorMsg = (state).errorMsg;
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(errorMsg),
              backgroundColor: Colors.black,
              duration: const Duration(seconds: 3),
            ),
          );
        }
      },
      child: Align(
        alignment: Alignment.centerRight,
        child: ElevatedButton(
          onPressed: () {
            _register(context);
          },
          style: ElevatedButton.styleFrom(
              minimumSize: const Size(110, 50),
              backgroundColor: Colors.black,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6))),
          child: const Text(
            'Next',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }

 /*  void _showProgressIndicator(BuildContext context) {
    AlertDialog alertDialog = const AlertDialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      content: Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation(Colors.black),
        ),
      ),
    ); */

    /* showDialog(
      barrierColor: Colors.white.withOpacity(0),
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return alertDialog;
      },
    );
  } */

  void _register(BuildContext context) async {
    try {
      if (!phoneFormKey.currentState!.validate()) {
        Navigator.pop(context);
        return;
      } else {
        Navigator.pop(context);
        phoneFormKey.currentState!.save();
        BlocProvider.of<PhoneAuthBloc>(context)
            .add(const SubmitPhoneNumberEvent());
      }
    } catch (e) {
      print(e.toString());
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Error!!"),
          backgroundColor: Colors.black,
          duration: Duration(seconds: 3),
        ),
      );
    }
  }
}
