import 'package:dartz/dartz.dart';
import 'package:iatec_authentication_core/src/domain/errors/errors.dart';
import 'package:iatec_authentication_core/src/domain/repositories/logout_repository.dart';
import 'package:iatec_authentication_core/src/infra/datasource/auth_datasource.dart';

class LogoutRepositoryImpl implements LogoutRepository {
  final AuthDatasource datasource;

  const LogoutRepositoryImpl({this.datasource});

  @override
  Future<Either<LogoutFailure, Unit>> logout() async {
    try {
      await datasource.logout();
      return Right(unit);
    } catch (e) {
      return Left(LogoutFailure(message: 'logoutRepositoryImpl.errorMessage'));
    }
  }
}
