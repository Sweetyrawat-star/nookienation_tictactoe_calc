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
    apiKey: 'AIzaSyDoDR5t8v2a8xbHma8UeTJqVEnMfjWesPA',
    appId: '1:1071721541502:web:db4be4c7a42d7dcf5bcd2f',
    messagingSenderId: '1071721541502',
    projectId: 'tiktak-afdb0',
    authDomain: 'tiktak-afdb0.firebaseapp.com',
    storageBucket: 'tiktak-afdb0.appspot.com',
    measurementId: 'G-W7VC1VS0KZ',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyANDuOKiULdRmRSleGLH6NteT8tOOXGvqY',
    appId: '1:1071721541502:android:4be9bd7d073199af5bcd2f',
    messagingSenderId: '1071721541502',
    projectId: 'tiktak-afdb0',
    storageBucket: 'tiktak-afdb0.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyB8C9rXkz_5-B5jm6YJwCNBbAyrfeiHreQ',
    appId: '1:1071721541502:ios:81c228e9349e9f4b5bcd2f',
    messagingSenderId: '1071721541502',
    projectId: 'tiktak-afdb0',
    storageBucket: 'tiktak-afdb0.appspot.com',
    iosBundleId: 'com.example.nookienation_tictactoe_calc',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyB8C9rXkz_5-B5jm6YJwCNBbAyrfeiHreQ',
    appId: '1:1071721541502:ios:294e85aeb863e82e5bcd2f',
    messagingSenderId: '1071721541502',
    projectId: 'tiktak-afdb0',
    storageBucket: 'tiktak-afdb0.appspot.com',
    iosBundleId: 'com.example.nookienation_tictactoe_calc.RunnerTests',
  );
}
