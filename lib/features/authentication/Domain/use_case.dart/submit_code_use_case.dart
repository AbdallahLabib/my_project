import 'package:dartz/dartz.dart';
import 'package:flutter_maps/core/error/faliures.dart';
import 'package:flutter_maps/features/authentication/domain/repository.dart/auth_repository.dart';

class SubmitOtpCodeUseCase {
  final AuthRepository authRepository;

  SubmitOtpCodeUseCase({required this.authRepository});

  Future<Either<Faliure, Unit>> call(otpCode) async {
    return await authRepository.submitOtpCode(otpCode);
  }
}
