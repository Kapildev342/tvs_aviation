import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart' show defaultTargetPlatform, kIsWeb, TargetPlatform;

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
    apiKey: 'AIzaSyDn4FOx5DD-QpKswQ7Xn7kyKKo8f7NJL_o',
    appId: '1:225958551702:android:f594c5ceef384aa2e3e2b7',
    messagingSenderId: '225958551702',
    projectId: 'tvsaviation-15b72',
    storageBucket: 'tvsaviation-15b72.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCiAiqs33M0nnkEhCH2LU5BUoyFbJIuDx8',
    appId: '1:225958551702:ios:c710d035e5a59b57e3e2b7',
    messagingSenderId: '225958551702',
    projectId: 'tvsaviation-15b72',
    storageBucket: 'tvsaviation-15b72.appspot.com',
    iosBundleId: 'com.tvs.tvs',
  );

}