part of 'email_bloc.dart';

sealed class EmailState extends Equatable {
  const EmailState();
  
  @override
  List<Object> get props => [];
}

final class EmailInitial extends EmailState {}

class EmailAndPasswordSubmittedState extends EmailState{
  
}
