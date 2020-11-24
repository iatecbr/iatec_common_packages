import 'package:dartz/dartz.dart';
import 'package:iatec_authentication_core/src/domain/entities/logged_user.dart';
import 'package:iatec_authentication_core/src/domain/errors/errors.dart';
import 'package:iatec_authentication_core/src/domain/services/get_logged_user_service.dart';
import 'package:iatec_authentication_core/src/infra/datasource/auth_datasource.dart';

class GetLoggedUserServiceImpl implements GetLoggedUserService {
  final AuthDatasource datasource;

  const GetLoggedUserServiceImpl({this.datasource});
  @override
  Future<Either<AuthFailure, LoggedUser>> getUser() async {
    try {
      final result = await datasource.getLoggedUser();
      if (result == null) {
        return Left(NotUserLogged());
      }
      return Right(result);
    } on AuthFailure catch (e) {
      return Left(e);
    } catch (e) {
      return Left(NotUserLogged());
    }
  }
}
