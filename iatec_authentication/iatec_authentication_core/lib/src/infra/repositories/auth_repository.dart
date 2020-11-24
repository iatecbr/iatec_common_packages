import 'package:dartz/dartz.dart';
import 'package:flutter/services.dart';
import 'package:iatec_authentication_core/src/domain/entities/logged_user.dart';
import 'package:iatec_authentication_core/src/domain/errors/errors.dart';
import 'package:iatec_authentication_core/src/domain/repositories/auth_repository.dart';
import 'package:iatec_authentication_core/src/infra/datasource/auth_datasource.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthDatasource datasource;

  const AuthRepositoryImpl({this.datasource});

  Future<Either<AuthFailure, LoggedUser>> _execute(
      Future<LoggedUser> Function() fuctionLoginFuture,
      AuthFailure error) async {
    try {
      final user = await fuctionLoginFuture();
      return Right(user);
    } on AuthFailure catch (ex) {
      return Left(ex);
    } on PlatformException catch (ex) {
      if (ex?.code == 'account-exists-with-different-credential') {
        return Left(DuplicatedAccountProviderError(
            message: 'AuthRepositoryImpl.DuplicatedAccountProviderError'));
      }
      return Left(error);
    } catch (ex) {
      return Left(error);
    }
  }

  @override
  Future<Either<AuthFailure, LoggedUser>> facebookLogin() {
    return _execute(
      datasource.loginWithFacebook,
      FacebookLoginError(message: 'auth.facebookLoginInternalError'),
    );
  }

  @override
  Future<Either<AuthFailure, LoggedUser>> googleLogin() {
    return _execute(
      datasource.loginWithGoogle,
      GoogleLoginError(message: 'auth.googleLoginInternalError'),
    );
  }

  @override
  Future<Either<AuthFailure, LoggedUser>> appleIdLogin() {
    return _execute(
      datasource.loginWithAppleId,
      AppleIdLoginError(message: 'auth.appleLoginInternalError'),
    );
  }
}
