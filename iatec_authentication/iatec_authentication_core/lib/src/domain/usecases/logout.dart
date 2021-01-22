import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:iatec_authentication_core/src/domain/errors/errors.dart';
import 'package:iatec_authentication_core/src/domain/repositories/logout_repository.dart';

abstract class Logout {
  Future<Either<LogoutFailure, Unit>> call();
}

class LogoutImpl implements Logout {
  final LogoutRepository repository;

  const LogoutImpl({@required this.repository});

  @override
  Future<Either<LogoutFailure, Unit>> call() async {
    return await repository.logout();
  }
}
