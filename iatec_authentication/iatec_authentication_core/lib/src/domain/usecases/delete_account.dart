import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:iatec_authentication_core/src/domain/errors/errors.dart';
import 'package:iatec_authentication_core/src/domain/repositories/delete_account_repository.dart';

abstract class DeleteAccount {
  Future<Either<AuthFailure, Unit>> call();
}

class DeleteAccountImpl implements DeleteAccount {
  final DeleteAccountRepository repository;

  const DeleteAccountImpl({@required this.repository});

  @override
  Future<Either<AuthFailure, Unit>> call() {
    return repository.delete();
  }
}
