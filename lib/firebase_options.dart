// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyCqD988F0ZGEaFf4TSAhtqzmTjb8PiIEN4',
    appId: '1:424581119730:web:a7e96e4060a19c615a5a6b',
    messagingSenderId: '424581119730',
    projectId: 'amar-notes-flutter-project',
    authDomain: 'amar-notes-flutter-project.firebaseapp.com',
    storageBucket: 'amar-notes-flutter-project.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyB2gm92seP80AJWegR0k4TXOIJ42rj6O94',
    appId: '1:424581119730:android:1fcf503c889da3d25a5a6b',
    messagingSenderId: '424581119730',
    projectId: 'amar-notes-flutter-project',
    storageBucket: 'amar-notes-flutter-project.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCxy_L9Rb8bM9SzhPyWMx3ugGEUtsL6x5k',
    appId: '1:424581119730:ios:8745b97f5ffff6625a5a6b',
    messagingSenderId: '424581119730',
    projectId: 'amar-notes-flutter-project',
    storageBucket: 'amar-notes-flutter-project.appspot.com',
    iosClientId: '424581119730-qpj1p6ek9cret51osgk3efiarma936br.apps.googleusercontent.com',
    iosBundleId: 'com.habibza.mynotes',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCxy_L9Rb8bM9SzhPyWMx3ugGEUtsL6x5k',
    appId: '1:424581119730:ios:8745b97f5ffff6625a5a6b',
    messagingSenderId: '424581119730',
    projectId: 'amar-notes-flutter-project',
    storageBucket: 'amar-notes-flutter-project.appspot.com',
    iosClientId: '424581119730-qpj1p6ek9cret51osgk3efiarma936br.apps.googleusercontent.com',
    iosBundleId: 'com.habibza.mynotes',
  );
}