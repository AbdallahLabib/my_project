import 'package:dartz/dartz.dart';
import 'package:flutter_maps/core/error/faliures.dart';
import 'package:flutter_maps/features/email_and_password/domain/repository/email_repository.dart';

class SignInWithEmailUSecase  {

final EmailRepository emailRepository ;

  SignInWithEmailUSecase({required this.emailRepository});

   Future<Either<Faliure, Unit>> call(email , password) async {
    return await emailRepository.submitEmailAndPassword(email,password);
  }
}