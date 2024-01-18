import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_maps/features/authentication/presentation/bloc/phone_auth_bloc.dart';
import 'package:flutter_maps/features/authentication/presentation/screens/login_screen.dart';
import 'package:flutter_maps/features/authentication/presentation/screens/otp_screen.dart';
import 'package:flutter_maps/features/maps/presentation/screens/map_screen.dart';
import 'core/constants/paths.dart';

class AppRouter {
  PhoneAuthBloc? phoneAuthBloPhoneAuthBloc;
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
                  value: phoneAuthBloPhoneAuthBloc!,
                  child: LoginScreen(),
                ));
      case otpScreen:
        final String phoneNumber = settings.arguments.toString();
        return MaterialPageRoute(
          builder: (_) => BlocProvider<PhoneAuthBloc>.value(
            value: phoneAuthBloPhoneAuthBloc!,
            child: OtpScreen(phoneNumber: phoneNumber),
          ),
        );
    }
    return null;
  }
}
