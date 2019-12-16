import 'dart:async';
import 'dart:convert';

import 'package:perguntando/src/shared/models/storage_store.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'notification_model.dart';

class SharedPreferencesNotificationStore implements StorageStore<List<NotificationModel>> {
  final _sharedPreferences = Completer<SharedPreferences>();

  SharedPreferencesNotificationStore() {
    if (!_sharedPreferences.isCompleted) {
      _sharedPreferences.complete(SharedPreferences.getInstance());
    }
  }

  @override
  Future<void> save(String key, List<NotificationModel> token) async {
    try {
      final storage = await _sharedPreferences.future;
      await storage.setString(key, jsonEncode(token));
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<NotificationModel>> read(String key) async {
    try {
      final storage = await _sharedPreferences.future;
      return storage.get(key);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> update(String key, List<NotificationModel> data) async {
    try {
      final storage = await _sharedPreferences.future;
      await storage.setString(key, jsonEncode(data));
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> delete(String key) async {
    try {
      final storage = await _sharedPreferences.future;
      await storage.remove(key);
    } catch (e) {
      rethrow;
    }
  }
}
