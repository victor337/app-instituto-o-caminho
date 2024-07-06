import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

class NonProdFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      default:
        return android;
    }
  }

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBwkzVEZdBtw4sIkPrC0BP5SsfvQhK_4Jk',
    appId: '1:710844560448:android:6839ce49da49bf886f9ba5',
    messagingSenderId: '710844560448',
    projectId: 'instituto-o-caminho-dev-a759d',
  );
}
