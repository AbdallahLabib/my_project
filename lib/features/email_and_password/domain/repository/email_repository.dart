import 'package:dartz/dartz.dart';

import '../../../../core/error/faliures.dart';

abstract class EmailRepository {
  Future<Either<Faliure, Unit>> submitEmailAndPassword(
      String email, String password);
}
