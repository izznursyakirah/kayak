import 'dart:io';
import 'package:firebase_core/firebase_core.dart';

class DefaultFirebaseConfig {
  static FirebaseOptions get plaftformOptions {
    if (Platform.isIOS) {
      return const FirebaseOptions(
        apiKey: 'AIzaSyCTTgMsDV4UZWa94l2X1TD7GXdvF9k6qWA',
        appId: '1:49442338167:android:71e78780647d44ab979d72',
        messagingSenderId: '49442338167',
        projectId: 'kayaksystem-f14d1',
        iosBundleId: '',
      );
    } else {
      return const FirebaseOptions(
        apiKey: 'AIzaSyCTTgMsDV4UZWa94l2X1TD7GXdvF9k6qWA',
        appId: '1:49442338167:android:71e78780647d44ab979d72',
        messagingSenderId: '49442338167',
        projectId: 'kayaksystem-f14d1',
      );
    }
  }
}
