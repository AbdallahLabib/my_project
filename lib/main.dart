// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_maps/app_router.dart';
import 'package:flutter_maps/features/phone_number_authentication/presentation/bloc/phone_auth_bloc.dart';
import 'package:flutter_maps/features/phone_number_authentication/presentation/widgets/injection_container.dart' as di;
import 'package:flutter_maps/features/push_notifications/data/firebase_api.dart';
import 'package:flutter_maps/firebase_options.dart';

//according to firebase docs i have to do the following before runApp Function

final navigatorKey = GlobalKey<NavigatorState>();
void main() async {
  //to use anything from firebase whether it is authentication databasse or anything, i must initalize firebase SDK
  // for firebase to initalize it need a native code from flutter
  //the following code ensure that the firebase has intialized in flutter
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await FirebaseApi().initNotification();

  await di.init();
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
        submitAndVerifyPhoneNumberUseCase: di.sl(),
        submitOtpCodeUseCase: di.sl(),
      ),
      child: MaterialApp(
        title: 'flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primarySwatch: Colors.blue),
        onGenerateRoute: appRouter.generateRoute,
        navigatorKey: navigatorKey,
        
      ),
    );
  }
}
