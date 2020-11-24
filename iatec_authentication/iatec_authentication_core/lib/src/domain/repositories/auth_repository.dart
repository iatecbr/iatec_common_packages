import 'package:dartz/dartz.dart';
import 'package:iatec_authentication_core/src/domain/entities/logged_user.dart';
import 'package:iatec_authentication_core/src/domain/errors/errors.dart';

abstract class AuthRepository {
  Future<Either<AuthFailure, LoggedUser>> googleLogin();
  Future<Either<AuthFailure, LoggedUser>> appleIdLogin();
  Future<Either<AuthFailure, LoggedUser>> facebookLogin();
}
