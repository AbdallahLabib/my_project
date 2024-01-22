import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_maps/core/constants/paths.dart';
import 'package:flutter_maps/core/widgets/show_progress_indicator.dart';
import 'package:flutter_maps/features/authentication/presentation/bloc/phone_auth_bloc.dart';

class SubmitPhoneNumberWidget extends StatelessWidget {
  final String phoneNumber;
  const SubmitPhoneNumberWidget({super.key, required this.phoneNumber});

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
          Navigator.pop(context);
          Navigator.of(context).pushNamed(otpScreen, arguments: phoneNumber);
        }

        if (state is ErrorOccuredState) {
          Navigator.pop(context);
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
    );
  }
}
