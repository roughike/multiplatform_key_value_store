import 'dart:async';

/// A platform agnostic interface for Multiplatform Dart projects.
///
/// Meant to be imported in your core business logic project.
/// Doesn't do anything by itself.
abstract class KeyValueStore {
  Set<String> getKeys();

  bool getBool(String key);
  int getInt(String key);
  double getDouble(String key);
  String getString(String key);
  List<String> getStringList(String key);

  Future<bool> setBool(String key, bool value);
  Future<bool> setInt(String key, int value);
  Future<bool> setDouble(String key, double value);
  Future<bool> setString(String key, String value);
  Future<bool> setStringList(String key, List<String> values);

  Future<bool> remove(String key);
  Future<bool> clear();
}
