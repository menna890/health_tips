import 'package:health_tips_app/firebase_options.dart';
import 'package:logger/logger.dart';
import 'package:firebase_core/firebase_core.dart';

class FirebaseConfig {
  static final Logger _logger = Logger();

  static Future<void> initialize() async {
    try {
      await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
      _logger.i('Firebase initialized');
    } catch (e) {
      _logger.e("Firebase initialization failed",error: e);
      rethrow;
    }
  }
}
