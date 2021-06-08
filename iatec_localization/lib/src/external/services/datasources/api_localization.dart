import 'package:dio/dio.dart';
import 'package:iatec_localization/src/infra/datasources/localization_datasource.dart';

class ApiLocalization implements LocalizationDatasource {
  final Dio dio;

  ApiLocalization(this.dio);

  @override
  Future<Map<String, String>> fetchLocalization(
      String url, String locale) async {
    final response = await dio.get<Map<String, String>>(
      url,
      options: Options(
        headers: <String, String>{
          'culture': locale,
        },
      ),
    );

    return (response.data).map<String, String>(
      (key, value) => MapEntry<String, String>(
        key.toString(),
        value.toString(),
      ),
    );
  }
}
