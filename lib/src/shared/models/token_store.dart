import 'dart:async';
import 'package:perguntando/src/shared/models/itoken_store.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesTokenStore implements TokenStore {
  final _key = "shared_preferences_authentication_token";
  final _sharedPreferences = Completer<SharedPreferences>();

  SharedPreferencesTokenStore() {
    if (!_sharedPreferences.isCompleted) {
      _sharedPreferences.complete(SharedPreferences.getInstance());
    }
  }

  @override
  Future<void> save(String token) async {
    try {
      final storage = await _sharedPreferences.future;
      await storage.setString(_key, token);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<String> read(String key) async {
    try {
      final storage = await _sharedPreferences.future;
      return storage.get(key);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> update(String token) async {
    try {
      final storage = await _sharedPreferences.future;
      await storage.setString(_key, token);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> delete() async {
    try {
      final storage = await _sharedPreferences.future;
      await storage.remove(_key);
    } catch (e) {
      rethrow;
    }
  }
}
