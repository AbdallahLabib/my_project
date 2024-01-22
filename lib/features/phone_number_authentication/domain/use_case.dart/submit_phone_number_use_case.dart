import 'package:dartz/dartz.dart';
import 'package:flutter_maps/core/error/faliures.dart';
import 'package:flutter_maps/features/phone_number_authentication/domain/repository.dart/auth_repository.dart';

class SubmitAndVerifyPhoneNumberUseCase {
  final AuthRepository authRepository;

  SubmitAndVerifyPhoneNumberUseCase({required this.authRepository});

  Future<Either<Faliure, Unit>> call(phoneNumber) async {
    return await authRepository.submitAndVerifyPhoneNumber(phoneNumber);
  }
}
