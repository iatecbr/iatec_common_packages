import 'package:dartz/dartz.dart';
import 'package:iatec_localization/src/domain/errors/errors.dart';
import 'package:iatec_localization/src/domain/repositories/localization_repository.dart';

abstract class GetCurrentLocale {
  Future<Either<LocalizationFailure, String>> call();
}

class GetCurrentLocaleImpl implements GetCurrentLocale {
  final LocalizationRepository repository;

  GetCurrentLocaleImpl(this.repository);

  @override
  Future<Either<LocalizationFailure, String>> call() {
    return repository.fetchLocale();
  }
}
