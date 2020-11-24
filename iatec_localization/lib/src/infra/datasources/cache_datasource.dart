abstract class CacheDatasource {
  Future<Map<String, String>> fetchCacheValue();
  Future<void> saveCache(Map<String, String> value);
  Future<void> saveLocale(String value);
  Future<String> fetchLocale();
}
