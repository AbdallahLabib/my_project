part of 'phone_auth_bloc.dart';

sealed class PhoneAuthState extends Equatable {
  const PhoneAuthState();
  
  @override
  List<Object> get props => [];
}

final class PhoneAuthInitial extends PhoneAuthState {}

class LoadingState extends PhoneAuthState {}

class ErrorOccuredState extends PhoneAuthState {
  final String errorMsg;

 const ErrorOccuredState({required this.errorMsg});
}

// when the user entered his phone number
class PhoneNumberSubmittedState extends PhoneAuthState {}

// when the user entered the OTP verification number
class OtpSubmittedState extends PhoneAuthState {}

