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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyC5aQfHStG_BpRzCc5-urhGj2bi1G4MhyI',
    appId: '1:606334408612:web:d9e0651036998bce9e1331',
    messagingSenderId: '606334408612',
    projectId: 'assignmentdemo-4f816',
    authDomain: 'assignmentdemo-4f816.firebaseapp.com',
    storageBucket: 'assignmentdemo-4f816.appspot.com',
    measurementId: 'G-2K9MH3J7KN',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCbew92XLh05T-QRCPgbN-tgpxNDQwYeKA',
    appId: '1:606334408612:android:a7d58f6e5eb489ee9e1331',
    messagingSenderId: '606334408612',
    projectId: 'assignmentdemo-4f816',
    storageBucket: 'assignmentdemo-4f816.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyB6pot_Nun3zZZRjaGhajP5Bh2Maz9wv0o',
    appId: '1:606334408612:ios:5fefbba0de9fc19d9e1331',
    messagingSenderId: '606334408612',
    projectId: 'assignmentdemo-4f816',
    storageBucket: 'assignmentdemo-4f816.appspot.com',
    iosBundleId: 'com.example.assignmentecom',
  );
}
