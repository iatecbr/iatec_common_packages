import 'package:adra_local_support/modules/local_support/domain/entities/national_support.dart';
import 'package:adra_local_support/modules/local_support/domain/erros/local_support_errors.dart';
import 'package:adra_local_support/modules/local_support/domain/repositories/local_support_repository.dart';
import 'package:dartz/dartz.dart';

abstract class IGetNationalSupports {
  Future<Either<LocalSupportFailure, List<NationalSupport>>> call(
      String countryId);
}

class GetNationalSupports extends IGetNationalSupports {
  final LocalSupportRepository repository;

  GetNationalSupports(this.repository);

  @override
  Future<Either<LocalSupportFailure, List<NationalSupport>>> call(
      String countryId) async {
    return await repository.getNationalSupports(countryId);
  }
}
