import 'package:flutter_maps/core/network/internet_connection_checker.dart';
import 'package:flutter_maps/features/phone_number_authentication/domain/repository.dart/auth_repository.dart';
import 'package:flutter_maps/features/phone_number_authentication/domain/use_case.dart/submit_code_use_case.dart';
import 'package:flutter_maps/features/phone_number_authentication/domain/use_case.dart/submit_phone_number_use_case.dart';
import 'package:flutter_maps/features/phone_number_authentication/data/data_sources/remote_data_source.dart';
import 'package:flutter_maps/features/phone_number_authentication/data/repositroy_impl/auth_repository_impl.dart';
import 'package:flutter_maps/features/phone_number_authentication/presentation/bloc/phone_auth_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //! Features - authentication
  // Bloc
  sl.registerFactory(() => PhoneAuthBloc(
        submitOtpCodeUseCase: sl(),
        submitAndVerifyPhoneNumberUseCase: sl(),
      ));

  // Usecases
  sl.registerLazySingleton(
      () => SubmitAndVerifyPhoneNumberUseCase(authRepository: sl()));
  sl.registerLazySingleton(() => SubmitOtpCodeUseCase(authRepository: sl()));

  // Repository
  sl.registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(networkInfo: sl(), authRemoteDataSource: sl()));

  // Datasources
  sl.registerLazySingleton<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImpl());

  //! Core
  sl.registerLazySingleton<NetworkInfo>(
      () => NetworkInfoImpl(connectionChecker: sl()));

  //! External
  sl.registerLazySingleton(() => InternetConnectionChecker());
}
