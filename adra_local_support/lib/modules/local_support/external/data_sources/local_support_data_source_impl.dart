import 'package:adra_local_support/modules/local_support/domain/entities/local_category.dart';
import 'package:adra_local_support/modules/local_support/domain/entities/local_support/local_support.dart';
import 'package:adra_local_support/modules/local_support/domain/entities/national_support.dart';
import 'package:adra_local_support/modules/local_support/external/models/local_category_model.dart';
import 'package:adra_local_support/modules/local_support/external/models/local_support/local_support_model.dart';
import 'package:adra_local_support/modules/local_support/external/models/national_support_model.dart';
import 'package:adra_local_support/modules/local_support/infra/data_sources/local_support_data_source.dart';
import 'package:dio/dio.dart';

class LocalSupportDataSourceImpl extends LocalSupportDataSource {
  final Dio _dio;

  LocalSupportDataSourceImpl(this._dio);

  @override
  Future<List<LocalCategory>> getLocalCategories() async {
    final response = await _dio.get('/common/support/local-categories');
    return LocalCategoryModel.fromJsonList(response.data);
  }

  @override
  Future<List<LocalSupport>> getLocalSupports(
    double latitude,
    double longitude, {
    String filter = '',
    List<int> categoriesId = const [],
  }) async {
    var categories =
        categoriesId?.map((e) => 'categoriesId:$e')?.toList()?.join('&') ?? '';

    final response = await _dio.get(
      '/common/support/local?latitude=$latitude&longitude=$longitude&filter=$filter&$categories',
    );
    return LocalSupportModel.fromJsonList(response.data);
  }

  @override
  Future<List<NationalSupport>> getNationalSupports(String countryId) async {
    final response = await _dio.get('/common/support/national/$countryId');
    return NationalSupportModel.fromJsonList(response.data);
  }
}
