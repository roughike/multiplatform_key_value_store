import 'dart:async';
import 'dart:convert';
import 'dart:html';

import 'package:key_value_store/key_value_store.dart';

/// A web implementation of a multiplatform key-value store.
///
/// To use, pass it a [Storage] from `dart:html` package.
///
/// For example:
///
/// ```
/// final kvs = WebKeyValueStore(window.localStorage);
/// kvs.setString('Hello', 'World!');
/// ```
class WebKeyValueStore implements KeyValueStore {
  WebKeyValueStore(this._storage);
  final Storage _storage;

  @override
  Set<String> getKeys() => _storage.keys.toSet();

  @override
  bool getBool(String key) => _storage[key] == 'true';

  @override
  int getInt(String key) => int.parse(_storage[key]);

  @override
  double getDouble(String key) => double.parse(_storage[key]);

  @override
  String getString(String key) => _storage[key];

  @override
  List<String> getStringList(String key) =>
      (json.decode(_storage[key]) as List).cast<String>();

  @override
  Future<bool> setBool(String key, bool value) => _setValue(key, value);

  @override
  Future<bool> setInt(String key, int value) => _setValue(key, value);

  @override
  Future<bool> setDouble(String key, double value) => _setValue(key, value);

  @override
  Future<bool> setString(String key, String value) => _setValue(key, value);

  @override
  Future<bool> setStringList(String key, List<String> values) => _setValue(key, values);

  @override
  Future<bool> remove(String key) {
    _storage.remove(key);
    return Future.value(true);
  }

  @override
  Future<bool> clear() {
    _storage.clear();
    return Future.value(true);
  }

  Future<bool> _setValue(String key, dynamic value) {
    if (value is String) {
      _storage[key] = value;
    } else if (value is bool || value is double || value is int) {
      _storage[key] = value.toString();
    } else if (value is List) {
      _storage[key] = json.encode(value);
    }

    return Future.value(true);
  }
}
