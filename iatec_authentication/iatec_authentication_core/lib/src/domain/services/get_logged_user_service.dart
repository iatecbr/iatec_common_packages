import 'package:dartz/dartz.dart';
import 'package:iatec_authentication_core/src/domain/entities/logged_user.dart';
import 'package:iatec_authentication_core/src/domain/errors/errors.dart';

abstract class GetLoggedUserService {
  Future<Either<AuthFailure, LoggedUser>> getUser();
}
