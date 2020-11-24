import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:iatec_authentication_core/src/domain/entities/logged_user.dart';
import 'package:iatec_authentication_core/src/domain/errors/errors.dart';
import 'package:iatec_authentication_core/src/domain/repositories/auth_repository.dart';

abstract class Login {
  Future<Either<AuthFailure, LoggedUser>> call(
      {@required ProviderLogin provider});
}

class LoginImpl implements Login {
  final AuthRepository repository;

  const LoginImpl({@required this.repository});

  @override
  Future<Either<AuthFailure, LoggedUser>> call(
      {@required ProviderLogin provider}) {
    switch (provider) {
      case ProviderLogin.google:
        return repository.googleLogin();
      case ProviderLogin.appleId:
        return repository.appleIdLogin();
      case ProviderLogin.facebook:
        return repository.facebookLogin();
      default:
        return null;
    }
  }
}
