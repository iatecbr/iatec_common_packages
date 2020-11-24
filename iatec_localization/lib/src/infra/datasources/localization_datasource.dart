abstract class LocalizationDatasource {
  Future<Map<String, String>> fetchLocalization(String url, String locale);
}
