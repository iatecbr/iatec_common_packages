import 'package:adra_local_support/modules/local_support/domain/entities/local_support/local_support.dart';
import 'package:adra_local_support/modules/local_support/domain/erros/local_support_errors.dart';
import 'package:adra_local_support/modules/local_support/domain/repositories/local_support_repository.dart';
import 'package:dartz/dartz.dart';

abstract class IGetLocalSupports {
  Future<Either<LocalSupportFailure, List<LocalSupport>>> call(
    double latitude,
    double longitude, {
    String filter,
    List<int> categoriesId,
  });
}

class GetLocalSupports extends IGetLocalSupports {
  final LocalSupportRepository repository;

  GetLocalSupports(this.repository);

  @override
  Future<Either<LocalSupportFailure, List<LocalSupport>>> call(
    double latitude,
    double longitude, {
    String filter = '',
    List<int> categoriesId,
  }) async {
    return await repository.getLocalSupports(
      latitude,
      longitude,
      filter,
      categoriesId,
    );
  }
}
