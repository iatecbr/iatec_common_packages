import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:iatec_authentication_core/src/domain/entities/logged_user.dart';
import 'package:iatec_authentication_core/src/domain/errors/errors.dart';
import 'package:iatec_authentication_core/src/domain/services/get_logged_user_service.dart';

abstract class GetLoggedUser {
  Future<Either<AuthFailure, LoggedUser>> call();
}

class GetLoggedUserImpl implements GetLoggedUser {
  final GetLoggedUserService service;

  const GetLoggedUserImpl({@required this.service});

  @override
  Future<Either<AuthFailure, LoggedUser>> call() {
    return service.getUser();
  }
}
