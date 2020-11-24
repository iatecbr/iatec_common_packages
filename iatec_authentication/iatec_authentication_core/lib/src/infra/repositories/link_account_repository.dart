import 'package:dartz/dartz.dart';
import 'package:iatec_authentication_core/src/domain/entities/logged_user.dart';
import 'package:iatec_authentication_core/src/domain/errors/errors.dart';
import 'package:iatec_authentication_core/src/domain/repositories/link_account_repository.dart';
import 'package:iatec_authentication_core/src/infra/datasource/auth_datasource.dart';

class LinkAccountRepositoryImpl implements LinkAccountRepository {
  final AuthDatasource datasource;

  LinkAccountRepositoryImpl({this.datasource});

  @override
  Future<Either<AuthFailure, LoggedUser>> linkAccount(
      ProviderLogin provider) async {
    try {
      final result = await datasource.linkAccount(provider);
      return Right(result);
    } on AuthFailure catch (e) {
      return Left(e);
    } catch (e) {
      return Left(LinkAccountError(
          message: 'linkAccountRepositoryImpl.linkAcountError'));
    }
  }

  @override
  Future<Either<AuthFailure, LoggedUser>> unlinkAccount(
      ProviderLogin provider) async {
    try {
      final result = await datasource.unlinkAccount(provider);
      return Right(result);
    } on AuthFailure catch (e) {
      return Left(e);
    } catch (e) {
      return Left(LinkAccountError(
          message: 'linkAccountRepositoryImpl.unlinkAcountError'));
    }
  }
}
