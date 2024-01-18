import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_maps/features/authentication/Domain/useCase.dart/submit_code.dart';
import 'package:flutter_maps/features/authentication/Domain/useCase.dart/submit_phone_number.dart';
part 'phone_auth_event.dart';
part 'phone_auth_state.dart';

class PhoneAuthBloc extends Bloc<PhoneAuthEvent, PhoneAuthState> {
  final SubmitOtpCodeUseCase submitOtpCodeUseCase;
  final SubmitAndVerifyPhoneNumberUseCase submitAndVerifyPhoneNumberUseCase;
  PhoneAuthBloc({
      required this.submitOtpCodeUseCase, required this.submitAndVerifyPhoneNumberUseCase})
      : super(PhoneAuthInitial()) {
    on<SubmitPhoneNumberEvent>(
      (event, emit) async {
        emit(LoadingState());
        final phoneVerified =
            await submitAndVerifyPhoneNumberUseCase(event.phoneNumber);
        return phoneVerified.fold(
            (faliure) => emit(ErrorOccuredState(errorMsg: faliure.errorMsg)),
            (_) => emit(PhoneNumberSubmittedState()));
      },
    );
    on<SubmitOtpCodeEvent>((event, emit) async{
      emit(LoadingState());
      final otpVerified = await submitOtpCodeUseCase(event.otpCode);
      return otpVerified.fold(
        (faliure) => emit(ErrorOccuredState(errorMsg: faliure.errorMsg)) , 
        (_)=> emit(OtpSubmittedState()));
    });
  }
}
