import 'dart:async';

abstract class StorageStore<T> {
  Future<void> save(String key, T data);
  Future<T> read(String key);
  Future<void> update(String key, T data);
  Future<void> delete(String key);
}
