import 'package:dartz/dartz.dart';
import 'package:iatec_authentication_core/src/domain/entities/logged_user.dart';
import 'package:iatec_authentication_core/src/domain/errors/errors.dart';

abstract class LinkAccountRepository {
  Future<Either<AuthFailure, LoggedUser>> linkAccount(ProviderLogin provider);
  Future<Either<AuthFailure, LoggedUser>> unlinkAccount(ProviderLogin provider);
}
