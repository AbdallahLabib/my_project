// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'phone_auth_bloc.dart';

sealed class PhoneAuthEvent extends Equatable {
  const PhoneAuthEvent();

  @override
  List<Object> get props => [];
}

class SubmitPhoneNumberEvent extends PhoneAuthEvent {
  final String phoneNumber;
  const SubmitPhoneNumberEvent({
    required this.phoneNumber,
  });
}

class SubmitOtpCodeEvent extends PhoneAuthEvent {
  final String otpCode;
  const SubmitOtpCodeEvent({
    required this.otpCode,
  });
}
