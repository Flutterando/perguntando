
abstract class TokenStore {
  Future<void> save(String data);
  Future<String> read(String key);
  Future<void> update(String data);
  Future<void> delete();
}
