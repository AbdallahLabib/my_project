import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_maps/features/email_and_password/presentation/screens/email_login_screen.dart';
import 'package:flutter_maps/features/email_and_password/presentation/screens/login_checker_screen.dart';
import 'package:flutter_maps/features/phone_number_authentication/presentation/bloc/phone_auth_bloc.dart';
import 'package:flutter_maps/features/phone_number_authentication/presentation/screens/login_screen.dart';
import 'package:flutter_maps/features/phone_number_authentication/presentation/screens/otp_screen.dart';
import 'package:flutter_maps/features/phone_number_authentication/presentation/widgets/injection_container.dart'
    as di;
import 'package:flutter_maps/features/maps/presentation/screens/map_screen.dart';
import 'package:flutter_maps/features/push_notifications/presentation/screens/notification_screen.dart';
import 'core/constants/paths.dart';

class AppRouter {
  final PhoneAuthBloc phoneAuthBloc = PhoneAuthBloc(
    submitOtpCodeUseCase: di.sl(),
    submitAndVerifyPhoneNumberUseCase: di.sl(),
  );
  // i created an instance of phoneAuthBloPhoneAuthBloc in app router Constructor so to use the PhoneAuthBloc in the class

//this is the function that will be responsible for routing and of typr Route Class
//object of RouteSetting called settings is put as a parameter for the generateRoute Function
  Route? generateRoute(RouteSettings settings) {
    //settings.name here because i will make a file cary the constants
    //this constats will have name and of type RouteSetting class and so by calling the name i will change the page
    switch (settings.name) {
      case mapScreen:
        return MaterialPageRoute(builder: (_) => const MapScreen());
      // i push the page by putting it in MaterialPageRoute class that have builder argument
      //the builder argument gets context  and return the class i made staeless widget which is a screen
      case loginScreen:
        return MaterialPageRoute(
          // the _ sign means fake parameter i.e will not be used
          builder: (_) => BlocProvider<PhoneAuthBloc>.value(
            value: phoneAuthBloc,
            child: LoginScreen(),
          ),
        );
      case otpScreen:
        final String phoneNumber = settings.arguments.toString();
        return MaterialPageRoute(
          builder: (_) => BlocProvider<PhoneAuthBloc>.value(
            value: phoneAuthBloc,
            child: OtpScreen(phoneNumber: phoneNumber),
          ),
        );

      case notificationScreen:
        return MaterialPageRoute(
          builder: (_) =>  NotificationScreen(
            message: settings.arguments as RemoteMessage?,
          ),
          settings: RouteSettings(
            name: settings.name,
            arguments: settings.arguments,
          ),
        );

        case emailLoginScreen:
        return MaterialPageRoute(builder: (_) => const EmailLoginScreen());

        case loginChecker:
        return MaterialPageRoute(builder: (_) => const LoginCheckerScreen());
    }
    return null;
  }
}
