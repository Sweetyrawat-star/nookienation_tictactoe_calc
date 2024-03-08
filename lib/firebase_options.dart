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
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for web - '
        'you can reconfigure this by running the FlutterFire CLI again.',
      );
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

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDGLzZ7-s3tVToOgabo0_ZDe2qWUD-H7cw',
    appId: '1:995544730444:android:7e1ff545886f2014c01de9',
    messagingSenderId: '995544730444',
    projectId: 'nookienation-tictactoe-calc',
    databaseURL: 'https://nookienation-tictactoe-calc-default-rtdb.firebaseio.com',
    storageBucket: 'nookienation-tictactoe-calc.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDzBw8BRsI8Sh3dlDboNUa4w77R_aEKfyk',
    appId: '1:995544730444:ios:d99bed12dd2cbab7c01de9',
    messagingSenderId: '995544730444',
    projectId: 'nookienation-tictactoe-calc',
    databaseURL: 'https://nookienation-tictactoe-calc-default-rtdb.firebaseio.com',
    storageBucket: 'nookienation-tictactoe-calc.appspot.com',
    androidClientId: '995544730444-u019jeqhf0hdv060l2clq6hskrdnddur.apps.googleusercontent.com',
    iosClientId: '995544730444-uu0lpn1lpfmve1dpdpqpf7l48c5besvj.apps.googleusercontent.com',
    iosBundleId: 'com.nookienationtictactoecalc',
  );
}