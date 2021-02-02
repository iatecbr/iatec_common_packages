import 'package:adra_local_support/modules/local_support/domain/entities/local_category.dart';
import 'package:adra_local_support/modules/local_support/domain/erros/local_support_errors.dart';
import 'package:adra_local_support/modules/local_support/domain/repositories/local_support_repository.dart';
import 'package:dartz/dartz.dart';

abstract class IGetLocalCategories {
  Future<Either<LocalSupportFailure, List<LocalCategory>>> call();
}

class GetLocalCategories extends IGetLocalCategories {
  final LocalSupportRepository repository;

  GetLocalCategories(this.repository);

  @override
  Future<Either<LocalSupportFailure, List<LocalCategory>>> call() async {
    return await repository.getLocalCategories();
  }
}
