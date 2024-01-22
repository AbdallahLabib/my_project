import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_maps/features/phone_number_authentication/domain/use_case.dart/submit_code_use_case.dart';
import 'package:flutter_maps/features/phone_number_authentication/domain/use_case.dart/submit_phone_number_use_case.dart';
part 'phone_auth_event.dart';
part 'phone_auth_state.dart';

class PhoneAuthBloc extends Bloc<PhoneAuthEvent, PhoneAuthState> {
  final SubmitOtpCodeUseCase submitOtpCodeUseCase;
  final SubmitAndVerifyPhoneNumberUseCase submitAndVerifyPhoneNumberUseCase;

  String phoneNumber = "";

  PhoneAuthBloc(
      {required this.submitOtpCodeUseCase,
      required this.submitAndVerifyPhoneNumberUseCase})
      : super(PhoneAuthInitial()) {
    on<SubmitPhoneNumberEvent>(
      (event, emit) async {
        emit(LoadingState());
        final phoneVerified =
            await submitAndVerifyPhoneNumberUseCase(phoneNumber);
        return phoneVerified.fold(
            (faliure) => emit(ErrorOccuredState(errorMsg: faliure.errorMsg)),
            (_) => emit(PhoneNumberSubmittedState()));
      },
    );
    on<SubmitOtpCodeEvent>((event, emit) async{
      emit(LoadingState());
      final otpVerified = await submitOtpCodeUseCase(event.otpCode);
      return otpVerified.fold(
          (faliure) => emit(ErrorOccuredState(errorMsg: faliure.errorMsg)),
          (_) => emit(OtpSubmittedState()));
    });
  }
}
