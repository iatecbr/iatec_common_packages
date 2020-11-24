import 'package:dartz/dartz.dart';
import 'package:iatec_authentication_core/src/domain/errors/errors.dart';

abstract class DeleteAccountRepository {
  Future<Either<AuthFailure, Unit>> delete();
}
