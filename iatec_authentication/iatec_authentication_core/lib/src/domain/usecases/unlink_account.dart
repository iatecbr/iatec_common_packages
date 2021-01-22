import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:iatec_authentication_core/src/domain/entities/logged_user.dart';
import 'package:iatec_authentication_core/src/domain/errors/errors.dart';
import 'package:iatec_authentication_core/src/domain/repositories/link_account_repository.dart';

abstract class UnLinkAccount {
  Future<Either<AuthFailure, LoggedUser>> call(ProviderLogin provider);
}

class UnLinkAccountImpl implements UnLinkAccount {
  final LinkAccountRepository repository;

  const UnLinkAccountImpl({@required this.repository});

  @override
  Future<Either<AuthFailure, LoggedUser>> call(ProviderLogin provider) async {
    return await repository.unlinkAccount(provider);
  }
}
