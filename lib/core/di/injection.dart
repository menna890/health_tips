import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:logger/logger.dart';
import 'package:health_tips_app/data/bloc/notification_bloc.dart';
import 'package:health_tips_app/data/services/notification_service.dart';
final getIt = GetIt.instance;

@injectableInit
void configureDependencies() {
  getIt.registerLazySingleton<NotificationService>(() => NotificationService(
    FirebaseMessaging.instance,
    FlutterLocalNotificationsPlugin(),
    Logger(),
  ));
  getIt.registerFactory(() => NotificationBloc(
    notificationService: getIt<NotificationService>()
  ));
  
}