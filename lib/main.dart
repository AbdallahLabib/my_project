// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_maps/app_router.dart';
import 'package:flutter_maps/features/authentication/presentation/bloc/phone_auth_bloc.dart';
import 'package:flutter_maps/features/authentication/presentation/widgets/injection_container.dart';
import 'package:flutter_maps/firebase_options.dart';

//according to firebase docs i have to do the following before runApp Function
void main() async {
  //to use anything from firebase whether it is authentication databasse or anything, i must initalize firebase SDK
  // for firebase to initalize it need a native code from flutter
  //the following code ensure that the firebase has intialized in flutter
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    FlutterMaps(
      // i created Anonymous object of the Class appRouter
      appRouter: AppRouter(),
    ),
  );
}

class FlutterMaps extends StatelessWidget {
  final AppRouter appRouter;
  const FlutterMaps({
    Key? key,
    required this.appRouter,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PhoneAuthBloc(
          submitAndVerifyPhoneNumberUseCase: sl(), submitOtpCodeUseCase: sl()), 
      child: MaterialApp(
        title: 'flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primarySwatch: Colors.blue),
        onGenerateRoute: appRouter.generateRoute,
      ),
    );
  }
}
