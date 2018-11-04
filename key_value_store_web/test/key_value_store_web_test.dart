@TestOn('browser')
import 'dart:convert';
import 'dart:html' show Storage;

import 'package:key_value_store_web/key_value_store_web.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

class MockStorage extends Mock implements Storage {}

void main() {
  group('A group of tests', () {
    MockStorage mockStorage;
    WebKeyValueStore localStorage;

    setUp(() {
      mockStorage = MockStorage();
      localStorage = WebKeyValueStore(mockStorage);
    });

    test('getKeys', () {
      when(mockStorage.keys).thenReturn(Set.from(['key #1', 'key #2']));

      expect(localStorage.getKeys(), ['key #1', 'key #2']);
    });

    test('getBool', () {
      when(mockStorage['myTrueBool']).thenReturn(json.encode(true));
      when(mockStorage['myFalseBool']).thenReturn(json.encode(false));

      expect(localStorage.getBool('myTrueBool'), isTrue);
      expect(localStorage.getBool('myFalseBool'), isFalse);
    });

    test('getInt', () {
      when(mockStorage['myInt']).thenReturn(json.encode(1337));

      expect(localStorage.getInt('myInt'), 1337);
    });

    test('getDouble', () {
      when(mockStorage['myDouble']).thenReturn(json.encode(1337.7331));

      expect(localStorage.getDouble('myDouble'), 1337.7331);
    });

    test('getString', () {
      when(mockStorage['myString']).thenReturn('Hello World!');

      expect(localStorage.getString('myString'), 'Hello World!');
    });

    test('getStringList', () {
      when(mockStorage['myStringList'])
          .thenReturn(json.encode(['value #1', 'value #2']));

      expect(
          localStorage.getStringList('myStringList'), ['value #1', 'value #2']);
    });

    test('setBool', () {
      localStorage.setBool('myTrueBool', true);
      localStorage.setBool('myFalseBool', false);

      verifyInOrder([
        mockStorage['myTrueBool'] = 'true',
        mockStorage['myFalseBool'] = 'false',
      ]);
    });

    test('setInt', () {
      localStorage.setInt('myInt', 1337);

      verify(mockStorage['myInt'] = '1337');
    });

    test('setDouble', () {
      localStorage.setDouble('myDouble', 1337.7331);

      verify(mockStorage['myDouble'] = '1337.7331');
    });

    test('setString', () {
      localStorage.setString('myString', 'myStringValue');

      verify(mockStorage['myString'] = 'myStringValue');
    });

    test('setStringList', () {
      localStorage.setStringList('myStringList', ['value #1', 'value #2']);

      verify(mockStorage['myStringList'] = '["value #1","value #2"]');
    });

    test('remove', () {
      localStorage.remove('myKey');

      verify(mockStorage.remove('myKey'));
    });

    test('clear', () {
      localStorage.clear();

      verify(mockStorage.clear());
    });
  });
}
