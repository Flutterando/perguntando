import 'dart:async';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'user_model.dart';

abstract class UserStore {
  Future<void> save(User data);
  Future<User> read();
  Future<void> update(User data);
  Future<void> delete();
}

class SharedPreferencesUserStore implements UserStore {
  final _key = 'shared_preferences_user';
  final _sharedPreferences = Completer<SharedPreferences>();

  SharedPreferencesUserStore() {
    if (!_sharedPreferences.isCompleted) {
      _sharedPreferences.complete(SharedPreferences.getInstance());
    }
  }

  @override
  Future<void> save(User data) async {
    try {
      final storage = await _sharedPreferences.future;
      await storage.setString(_key, jsonEncode(data));
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<User> read() async {
    try {
      final storage = await _sharedPreferences.future;
      return User.fromJson(storage.get(_key));
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> update(User data) async {
    try {
      final storage = await _sharedPreferences.future;
      await storage.setString(_key, jsonEncode(data));
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
