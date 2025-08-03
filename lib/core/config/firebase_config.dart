import 'package:logger/logger.dart';
import 'package:firebase_core/firebase_core.dart';

class FirebaseConfig {
  static final Logger _logger = Logger();

  static Future<void> nitialize() async {
    try {
      await Firebase.initializeApp();
      _logger.i('Firebase initialized');
    } catch (e) {
      _logger.e("Firebase initialization failed",error: e);
      rethrow;
    }
  }
}
