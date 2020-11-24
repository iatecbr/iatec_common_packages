import 'package:dartz/dartz.dart';
import 'package:iatec_authentication_core/src/domain/errors/errors.dart';
import 'package:iatec_authentication_core/src/domain/repositories/delete_account_repository.dart';
import 'package:iatec_authentication_core/src/infra/datasource/auth_datasource.dart';

class DeleteAccountRepositoryImpl implements DeleteAccountRepository {
  final AuthDatasource datasource;

  const DeleteAccountRepositoryImpl({this.datasource});

  @override
  Future<Either<AuthFailure, Unit>> delete() async {
    try {
      await datasource.deleteAccount();
      return Right(unit);
    } on AuthFailure catch (e) {
      return Left(e);
    } catch (e) {
      return Left(DeleteAccountError(
          message: 'deleteAccountRepositoryImpl.errorMessage'));
    }
  }
}
