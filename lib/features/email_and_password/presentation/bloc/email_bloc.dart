import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'email_event.dart';
part 'email_state.dart';

class EmailBloc extends Bloc<EmailEvent, EmailState> {
  EmailBloc() : super(EmailInitial()) {
    on<EmailEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
