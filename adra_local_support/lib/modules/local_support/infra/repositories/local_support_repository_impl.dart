import 'package:adra_local_support/modules/local_support/domain/entities/local_category.dart';
import 'package:adra_local_support/modules/local_support/domain/entities/local_support/local_support.dart';
import 'package:adra_local_support/modules/local_support/domain/entities/national_support.dart';
import 'package:adra_local_support/modules/local_support/domain/erros/local_support_errors.dart';
import 'package:adra_local_support/modules/local_support/domain/repositories/local_support_repository.dart';
import 'package:adra_local_support/modules/local_support/infra/data_sources/local_support_data_source.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

class LocalSupportRepositoryImpl extends LocalSupportRepository {
  final LocalSupportDataSource dataSource;

  LocalSupportRepositoryImpl(this.dataSource);

  @override
  Future<Either<LocalSupportFailure, List<LocalCategory>>>
      getLocalCategories() async {
    try {
      var result = await dataSource.getLocalCategories();
      return Right(result);
    } on DioError catch (e) {
      if (e.response.statusCode == 401) {
        throw LocalSupportFailure(e,
            message: 'localSupportRepositoryImpl.unauthorized');
      }
      return Left(LocalSupportFailure(e));
    } catch (e) {
      return e is LocalSupportFailure ? Left(e) : Left(LocalSupportFailure(e));
    }
  }

  @override
  Future<Either<LocalSupportFailure, List<LocalSupport>>> getLocalSupports(
    double latitude,
    double longitude,
    String filter,
    List<int> categoriesId,
  ) async {
    try {
      var result = await dataSource.getLocalSupports(
        latitude,
        longitude,
        filter: filter,
        categoriesId: categoriesId,
      );
      return Right(result);
    } on DioError catch (e) {
      if (e.response.statusCode == 401) {
        throw LocalSupportFailure(e,
            message: 'localSupportRepositoryImpl.unauthorized');
      }
      return Left(LocalSupportFailure(e));
    } catch (e) {
      return e is LocalSupportFailure ? Left(e) : Left(LocalSupportFailure(e));
    }
  }

  @override
  Future<Either<LocalSupportFailure, List<NationalSupport>>>
      getNationalSupports(String countryId) async {
    try {
      var result = await dataSource.getNationalSupports(countryId);
      return Right(result);
    } on DioError catch (e) {
      if (e.response.statusCode == 401) {
        throw LocalSupportFailure(e,
            message: 'localSupportRepositoryImpl.unauthorized');
      }
      return Left(LocalSupportFailure(e));
    } catch (e) {
      return e is LocalSupportFailure ? Left(e) : Left(LocalSupportFailure(e));
    }
  }
}
