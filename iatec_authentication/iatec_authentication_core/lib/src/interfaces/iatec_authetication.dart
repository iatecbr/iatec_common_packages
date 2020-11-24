import 'package:dartz/dartz.dart';
import 'package:iatec_authentication_core/iatec_authentication_core.dart';
import 'package:iatec_authentication_core/src/domain/entities/logged_user.dart';
import 'package:iatec_authentication_core/src/infra/datasource/auth_datasource.dart';

abstract class IATecAuthetication {
  Future<Either<AuthFailure, Unit>> deleteAccount();
  Future<Either<AuthFailure, LoggedUser>> getLoggedUser();
  Future<Either<AuthFailure, LoggedUser>> linkAccount(ProviderLogin provider);
  Future<Either<AuthFailure, LoggedUser>> login(ProviderLogin provider);
  Future<Either<LogoutFailure, Unit>> logout();
  Future<Either<AuthFailure, LoggedUser>> unLinkAccount(ProviderLogin provider);
  void registerAuthDatasource(AuthDatasource datasource);
  void changeRegister<T>(T instance);
}
