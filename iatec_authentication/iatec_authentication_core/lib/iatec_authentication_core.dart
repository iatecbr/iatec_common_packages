library iatec_authentication_core;

export 'src/domain/entities/logged_user.dart';
export 'src/domain/errors/errors.dart';
export 'src/infra/datasource/auth_datasource.dart';

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:iatec_authentication_core/src/core_module.dart';
import 'package:iatec_authentication_core/src/infra/datasource/auth_datasource.dart';
import 'package:iatec_authentication_core/src/domain/entities/logged_user.dart';
import 'package:iatec_authentication_core/src/interfaces/iatec_authetication.dart';

import 'src/domain/errors/errors.dart';
import 'src/domain/usecases/delete_account.dart';
import 'src/domain/usecases/get_logged_user.dart';
import 'src/domain/usecases/link_account.dart';
import 'src/domain/usecases/login.dart';
import 'src/domain/usecases/logout.dart';
import 'src/domain/usecases/unlink_account.dart';

// ignore: non_constant_identifier_names
final IATecAuth = _IATecAutheticationImpl();

class _IATecAutheticationImpl implements IATecAuthetication {
  @override
  Future<Either<AuthFailure, Unit>> deleteAccount() {
    return authModule.resolve<DeleteAccount>()();
  }

  @override
  Future<Either<AuthFailure, LoggedUser>> getLoggedUser() {
    return authModule.resolve<GetLoggedUser>()();
  }

  @override
  Future<Either<AuthFailure, LoggedUser>> linkAccount(ProviderLogin provider) {
    return authModule.resolve<LinkAccount>()(provider);
  }

  @override
  Future<Either<AuthFailure, LoggedUser>> login(ProviderLogin provider) {
    return authModule.resolve<Login>()(provider: provider);
  }

  @override
  Future<Either<LogoutFailure, Unit>> logout() {
    return authModule.resolve<Logout>()();
  }

  @override
  Future<Either<AuthFailure, LoggedUser>> unLinkAccount(
      ProviderLogin provider) {
    return authModule.resolve<UnLinkAccount>()(provider);
  }

  @override
  void registerAuthDatasource(AuthDatasource instance) {
    authModule.registerInstance<AuthDatasource>(instance);
  }

  @visibleForTesting
  @override
  void changeRegister<T>(T instance) {
    authModule.unregister<T>();
    authModule.registerInstance<T>(instance);
  }
}
