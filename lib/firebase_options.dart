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
    apiKey: 'AIzaSyBexDCJUWVCxkRcJZ7_OXut-tQDujsox38',
    appId: '1:874097209902:web:1f8c6d82eb2c3c7900e5bf',
    messagingSenderId: '874097209902',
    projectId: 'ewce-deb23',
    authDomain: 'ewce-deb23.firebaseapp.com',
    storageBucket: 'ewce-deb23.appspot.com',
    measurementId: 'G-XJLLPK94F2',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDzrgon4j4w6BvAYTmpLOBLQbHdQ5Vgmd4',
    appId: '1:874097209902:android:9466b50e54bda3d600e5bf',
    messagingSenderId: '874097209902',
    projectId: 'ewce-deb23',
    storageBucket: 'ewce-deb23.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBhDZNz8E6jsZBMQChb7piYuL_ZKU-as3E',
    appId: '1:874097209902:ios:cb2b34d13c0d1b2d00e5bf',
    messagingSenderId: '874097209902',
    projectId: 'ewce-deb23',
    storageBucket: 'ewce-deb23.appspot.com',
    iosBundleId: 'com.example.firstApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBhDZNz8E6jsZBMQChb7piYuL_ZKU-as3E',
    appId: '1:874097209902:ios:6b3ae25fd456220800e5bf',
    messagingSenderId: '874097209902',
    projectId: 'ewce-deb23',
    storageBucket: 'ewce-deb23.appspot.com',
    iosBundleId: 'com.example.firstApp.RunnerTests',
  );
}
