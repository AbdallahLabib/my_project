import 'package:equatable/equatable.dart';

class PhoneAuth extends Equatable {
 final String phoneNumber ;
 final String otp ;

 const PhoneAuth({required this.phoneNumber, required this.otp});
 @override
  List<Object?> get props => throw UnimplementedError();

}