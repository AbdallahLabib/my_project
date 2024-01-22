import 'package:dartz/dartz.dart';
import 'package:flutter_maps/core/error/exception.dart';
import 'package:flutter_maps/core/error/faliures.dart';
import 'package:flutter_maps/core/network/internet_connection_checker.dart';
import 'package:flutter_maps/features/phone_number_authentication/domain/repository.dart/auth_repository.dart';
import 'package:flutter_maps/features/phone_number_authentication/data/data_sources/remote_data_source.dart';

class AuthRepositoryImpl extends AuthRepository {
  final NetworkInfo networkInfo;
  final AuthRemoteDataSource authRemoteDataSource;

  AuthRepositoryImpl(
      {required this.networkInfo, required this.authRemoteDataSource});
  @override
  Future<Either<Faliure, Unit>> submitAndVerifyPhoneNumber(
      String phoneNumber) async {
    if (await networkInfo.isConnected) {
      try {
        await authRemoteDataSource.submitAndVerifyPhoneNumber(phoneNumber);
        return const Right(unit);
      } on ServerException {
        return Left(ServerFaliure());
      }
    } else {
      return Left(OfflineFaliure());
    }
  }

  @override
  Future<Either<Faliure, Unit>> submitOtpCode(otpCode) async {
    if (await networkInfo.isConnected) {
      try {
        await authRemoteDataSource.submitOtpCode(otpCode);
        return const Right(unit);
      } on ServerException {
        return Left(ServerFaliure());
      }
    } else {
      return Left(OfflineFaliure());
    }
  }
}
