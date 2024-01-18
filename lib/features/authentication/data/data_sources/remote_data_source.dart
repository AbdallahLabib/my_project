// ignore_for_file: avoid_print

import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_maps/core/error/exception.dart';

abstract class AuthRemoteDataSource {
  Future<void> submitAndVerifyPhoneNumber(String phoneNumber);
  Future<Unit> submitOtpCode(otpCode);
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  late String verificationID;
  @override
  Future<void> submitAndVerifyPhoneNumber(phoneNumber) async {
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: '+20$phoneNumber',
      timeout: const Duration(seconds: 15),
      verificationCompleted: verificationCompleted,
      verificationFailed: verificationFailed,
      codeSent: codeSent,
      codeAutoRetrievalTimeout: codeAutoRetrievalTimeout,
    );
  }

  // this function for the mobile to directly insert the Verification  code
  Future<Unit> verificationCompleted(PhoneAuthCredential credential) async {
    print('Verification Complete');
    try {
      await FirebaseAuth.instance.signInWithCredential(credential);
      return Future.value(unit);
      //emit(PhoneOtpVerified());
    } catch (error) {
      throw ServerException();
      //emit(ErrorOccuredState(errorMsg: error.toString()));
    }
  }

  void verificationFailed(FirebaseAuthException error) {
    print('Verification Failed : ${error.toString()}');
  }

  void codeSent(String verificationId, int? resendToken) {
    print('Code Sent');
    verificationID = verificationId;
    //emit(PhoneNumberSubmittedState());
  }

  void codeAutoRetrievalTimeout(String verificationId) {
    print('code Auto Retrieval Timeout');
  }

  @override
  Future<Unit> submitOtpCode(otpCode) async {
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationID, smsCode: otpCode);
    try {
      await signIn(credential);
      return Future.value(unit);
    } catch (error) {
      throw ServerException();
    }
  }

  Future<void> signIn(PhoneAuthCredential credential) async {
    await FirebaseAuth.instance.signInWithCredential(credential);
  }
}
 // }
