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
So for example, `localStorage` for web or `SharedPreferences` for Flutter in your pure business logic are a no-no.

But you must still be able call the APIs for storing and retrieving data locally in your business logic. 
Which is exactly where this package comes into play; since the package is just an abstract class, you can import it safely in your core module.

## key_value_store_flutter

This implements the abstract class defined in `key_value_store` with Flutter-specific implementation. 
In this case, using `SharedPreferences`. 

Pass it an instance of `SharedPreferences` and you're good to go!

## key_value_store_web

This is also an implementation of the interface defined in the `key_value_store` package.
Pass it `window.localStorage` or `window.sessionStorage` from the `dart:html` package and you're good to go.
