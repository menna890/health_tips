import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:health_tips_app/core/config/firebase_config.dart';
import 'package:health_tips_app/core/di/injection.dart';
import 'package:health_tips_app/presentation/healthtipsapp.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:logger/logger.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final logger = Logger();
  
  try {
    
    logger.i('Initializing Firebase...');
    await FirebaseConfig.nitialize();
    
    
    logger.i('Configuring dependencies...');
    final sharedPrefs = await SharedPreferences.getInstance();
    GetIt.I.registerSingleton(sharedPrefs);
    configureDependencies();
    
    
    logger.i('Starting application...');
    runApp(const HealthTipsApp());
  } catch (e, stackTrace) {
    logger.e('Application startup failed', error: e, stackTrace: stackTrace);
  }
}