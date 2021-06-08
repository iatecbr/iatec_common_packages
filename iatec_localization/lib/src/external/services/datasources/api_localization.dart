import 'package:dio/dio.dart';
import 'package:iatec_localization/src/infra/datasources/localization_datasource.dart';

// ignore_for_file: implicit_dynamic_map_literal, implicit_dynamic_parameter, implicit_dynamic_method
class ApiLocalization implements LocalizationDatasource {
  final Dio dio;

  ApiLocalization(this.dio);

  @override
  Future<Map<String, String>> fetchLocalization(
      String url, String locale) async {
    final response =
        await dio.get(url, options: Options(headers: {'culture': locale}));
    return (response.data as Map).map<String, String>((key, value) =>
        MapEntry<String, String>(key.toString(), value.toString()));
  }
}
