part of 'email_bloc.dart';

sealed class EmailEvent extends Equatable {
  const EmailEvent();

  @override
  List<Object> get props => [];
}

class SubmitEmailAndPasswordEvent extends EmailEvent{
  
}
