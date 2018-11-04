# Multiplatform key-value store for multiplatform Dart projects

> What the heck is that?

Glad you asked! <sub><sup>(docs are work in progress, but the libraries are stable.)</sup></sub>

Multiplatform key-value store is like any other key value store, but it's _multiplatform_. Badum-tss!

# Package overview

This repo contains three different folders. Each of them is a Dart package project.

## key_value_store

The `key_value_store` package defines common key-value storage APIs in an abstract way without caring about the implementation.

You might ask what is the point for this, and that is an entirely valid question!
When you're doing code sharing across Flutter and the web, you can't import platform specific dependencies in your core business logic components.
Using `localStorage` for web or `SharedPreferences` for Flutter in your pure business logic is a no-no.

Here's how you would use the abstract class in your common business logic:

```dart
import 'package:key_value_store/key_value_store.dart';

class MyBusinessLogic {
  MyBusinessLogic(this.kvs);
  final KeyValueStore kvs;
  
  void storeHelloMessage(String name) {
    kvs.setString('message', 'Hello, $name!');
  }
}
```

## key_value_store_flutter

This implements the abstract class defined in `key_value_store` with Flutter-specific implementation. 
In this case, using `SharedPreferences`. 

To use, pass it `SharedPreferences` from the [shared_preferences](https://pub.dartlang.org/packages/shared_preferences) Flutter plugin package:

```dart
import 'package:key_value_store_flutter/key_value_store_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

final prefs = await SharedPreferences.getInstance();
final kvs = FlutterKeyValueStore(prefs);
...
// Time to store some values somewhere in your common business logic!
final myBusinessLogic = MyBusinessLogic(kvs);
myBusinessLogic.storeHelloMessage('John Doe');
```

## key_value_store_web

This is also an implementation of the interface defined in the `key_value_store` package.
Pass it `window.localStorage` or `window.sessionStorage` from the `dart:html` package and you're good to go:

```dart
import 'package:key_value_store_web/key_value_store_web.dart';
import 'dart:html';

final kvs = WebKeyValueStore(window.localStorage);
...
// Time to store some values somewhere in your common business logic!
final myBusinessLogic = MyBusinessLogic(kvs);
myBusinessLogic.storeHelloMessage('John Doe');
```
