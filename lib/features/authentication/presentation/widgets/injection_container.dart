import 'package:flutter_maps/core/network/internet_connection_checker.dart';
import 'package:flutter_maps/features/authentication/Domain/repository.dart/auth_repository.dart';
import 'package:flutter_maps/features/authentication/Domain/useCase.dart/submit_code.dart';
import 'package:flutter_maps/features/authentication/Domain/useCase.dart/submit_phone_number.dart';
import 'package:flutter_maps/features/authentication/data/data_sources/remote_data_source.dart';
import 'package:flutter_maps/features/authentication/data/repositroy_impl/auth_repository_impl.dart';
import 'package:flutter_maps/features/authentication/presentation/bloc/phone_auth_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

final sl = GetIt.instance;

Future<void> init() async {
//! Features - posts

// Bloc

  sl.registerFactory(() => PhoneAuthBloc(
      submitOtpCodeUseCase: sl(), submitAndVerifyPhoneNumberUseCase: sl()));

// Usecases

  sl.registerLazySingleton(
      () => SubmitAndVerifyPhoneNumberUseCase(authRepository: sl()));
  sl.registerLazySingleton(() => SubmitOtpCodeUseCase(authRepository: sl()));

// Repository

  sl.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(networkInfo: sl(),
      authRemoteDataSource: sl()));

// Datasources
  sl.registerLazySingleton<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImpl());
  

//! Core

  sl.registerLazySingleton<NetworkInfo>(
      () => NetworkInfoImpl(connectionChecker: sl()));

//! External

  
  sl.registerLazySingleton(() => InternetConnectionChecker());
}
