import 'package:key_value_store_flutter/key_value_store_flutter.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_test/flutter_test.dart';

class MockSharedPrefs extends Mock implements SharedPreferences {}

void main() {
  group('A group of tests', () {
    MockSharedPrefs mockSharedPrefs;
    FlutterKeyValueStore keyValueStore;

    setUp(() {
      mockSharedPrefs = MockSharedPrefs();
      keyValueStore = FlutterKeyValueStore(mockSharedPrefs);
    });

    test('getKeys', () {
      when(mockSharedPrefs.getKeys())
          .thenReturn(Set.from(['key #1', 'key #2']));

      expect(keyValueStore.getKeys(), ['key #1', 'key #2']);
    });

    test('getBool', () {
      when(mockSharedPrefs.getBool('myTrueBool')).thenReturn(true);
      when(mockSharedPrefs.getBool('myFalseBool')).thenReturn(false);

      expect(keyValueStore.getBool('myTrueBool'), isTrue);
      expect(keyValueStore.getBool('myFalseBool'), isFalse);
    });

    test('getInt', () {
      when(mockSharedPrefs.getInt('myInt')).thenReturn(1337);

      expect(keyValueStore.getInt('myInt'), 1337);
    });

    test('getDouble', () {
      when(mockSharedPrefs.getDouble('myDouble')).thenReturn(1337.7331);

      expect(keyValueStore.getDouble('myDouble'), 1337.7331);
    });

    test('getString', () {
      when(mockSharedPrefs.getString('myString')).thenReturn('Hello World!');

      expect(keyValueStore.getString('myString'), 'Hello World!');
    });

    test('getStringList', () {
      when(mockSharedPrefs.getStringList('myStringList'))
          .thenReturn(['value #1', 'value #2']);

      expect(keyValueStore.getStringList('myStringList'),
          ['value #1', 'value #2']);
    });

    test('setBool', () {
      keyValueStore.setBool('myTrueBool', true);
      keyValueStore.setBool('myFalseBool', false);

      verifyInOrder([
        mockSharedPrefs.setBool('myTrueBool', true),
        mockSharedPrefs.setBool('myFalseBool', false),
      ]);
    });

    test('setInt', () {
      keyValueStore.setInt('myInt', 1337);

      verify(mockSharedPrefs.setInt('myInt', 1337));
    });

    test('setDouble', () {
      keyValueStore.setDouble('myDouble', 1337.7331);

      verify(mockSharedPrefs.setDouble('myDouble', 1337.7331));
    });

    test('setString', () {
      keyValueStore.setString('myString', 'myStringValue');

      verify(mockSharedPrefs.setString('myString', 'myStringValue'));
    });

    test('setStringList', () {
      keyValueStore.setStringList('myStringList', ['value #1', 'value #2']);

      verify(mockSharedPrefs
          .setStringList('myStringList', ['value #1', 'value #2']));
    });

    test('remove', () {
      keyValueStore.remove('myKey');

      verify(mockSharedPrefs.remove('myKey'));
    });

    test('clear', () {
      keyValueStore.clear();

      verify(mockSharedPrefs.clear());
    });
  });
}
