import 'package:adra_local_support/modules/local_support/domain/entities/local_category.dart';
import 'package:adra_local_support/modules/local_support/domain/entities/local_support/local_support.dart';
import 'package:adra_local_support/modules/local_support/domain/entities/national_support.dart';
import 'package:adra_local_support/modules/local_support/domain/erros/local_support_errors.dart';
import 'package:dartz/dartz.dart';

abstract class LocalSupportRepository {
  Future<Either<LocalSupportFailure, List<NationalSupport>>>
      getNationalSupports(String countryId);
  Future<Either<LocalSupportFailure, List<LocalSupport>>> getLocalSupports(
    double latitude,
    double longitude,
    String filter,
    List<int> categoriesId,
  );

  Future<Either<LocalSupportFailure, List<LocalCategory>>> getLocalCategories();
}
