import 'package:adra_local_support/modules/local_support/domain/entities/local_category.dart';
import 'package:adra_local_support/modules/local_support/domain/entities/local_support/local_support.dart';
import 'package:adra_local_support/modules/local_support/domain/entities/national_support.dart';

abstract class LocalSupportDataSource {
  Future<List<NationalSupport>> getNationalSupports(String countryId);
  Future<List<LocalSupport>> getLocalSupports(
    double latitude,
    double longitude, {
    String filter,
    List<int> categoriesId,
  });
  Future<List<LocalCategory>> getLocalCategories();
}
