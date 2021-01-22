import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:iatec_authentication_core/src/domain/entities/logged_user.dart';
import 'package:iatec_authentication_core/src/domain/errors/errors.dart';
import 'package:iatec_authentication_core/src/domain/services/get_logged_user_service.dart';

abstract class GetLoggedUser {
  ///[checkToken] return true if token is valid
  ///when token is invalid, will try again.
  ///[tryAgainTime] defaul is 800 miliseconds.
  Future<Either<AuthFailure, LoggedUser>> call({bool Function(String token) checkToken, Duration tryAgainTime: const Duration(milliseconds: 800)});
}

class GetLoggedUserImpl implements GetLoggedUser {
  final GetLoggedUserService service;

  const GetLoggedUserImpl({@required this.service});

  @override
  Future<Either<AuthFailure, LoggedUser>> call({bool Function(String token) checkToken, Duration tryAgainTime: const Duration(milliseconds: 800)}) async {
    if (checkToken == null) {
      return await service.getUser();
    }

    while (true) {
      final result = await service.getUser();
      if (result.isLeft()) {
        return result;
      }
      final user = result | null;
      if (!checkToken(user.token)) {
        print('invalid token: try again...');
        await Future.delayed(tryAgainTime);
        continue;
      }
      return result;
    }
  }
}
