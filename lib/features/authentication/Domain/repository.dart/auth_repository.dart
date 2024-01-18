import 'package:dartz/dartz.dart';
import 'package:flutter_maps/core/error/faliures.dart';

abstract class AuthRepository {
  Future<Either<Faliure, Unit>> submitAndVerifyPhoneNumber(String phoneNumber);
  Future<Either<Faliure, Unit>> submitOtpCode(String otpCode);
}
