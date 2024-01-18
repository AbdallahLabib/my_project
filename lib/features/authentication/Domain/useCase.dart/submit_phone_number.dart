import 'package:dartz/dartz.dart';
import 'package:flutter_maps/core/error/faliures.dart';
import 'package:flutter_maps/features/authentication/Domain/repository.dart/auth_repository.dart';

class SubmitAndVerifyPhoneNumberUseCase{
  final AuthRepository authRepository ;

  SubmitAndVerifyPhoneNumberUseCase({required this.authRepository});

  Future<Either<Faliure,Unit>> call (String phoneNumber)async{
return await authRepository.submitAndVerifyPhoneNumber(phoneNumber);
  }
}