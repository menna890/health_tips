import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:logger/logger.dart';

class NotificationService {
  final FirebaseMessaging _firebaseMessaging;
  final FlutterLocalNotificationsPlugin _localNotifications;
  final Logger _logger;

  NotificationService(
    this._firebaseMessaging,
    this._localNotifications,
    this._logger,
  );

  Future<void> initialize() async {
    await _setupNotifications();
  }

  Future<void> _setupNotifications() async {
   
    final settings = await _firebaseMessaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );
    _logger.i('Notification permissions: ${settings.authorizationStatus}');

    
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    await _localNotifications.initialize(
      const InitializationSettings(android: initializationSettingsAndroid),
    );

    
    FirebaseMessaging.onMessage.listen(_showNotification);
  }

  Future<void> subscribeToTopics(int age, String fitnessGoal) async {
    final ageGroup = _getAgeGroup(age);
    await _firebaseMessaging.subscribeToTopic('health_tips_age_$ageGroup');
    await _firebaseMessaging.subscribeToTopic('health_tips_goal_$fitnessGoal');
  }

  Future<void> unsubscribeFromAllTopics() async {
    await _firebaseMessaging.unsubscribeFromTopic('health_tips_age_*');
    await _firebaseMessaging.unsubscribeFromTopic('health_tips_goal_*');
  }

  String _getAgeGroup(int age) {
    if (age < 20) return 'under20';
    if (age < 30) return '20s';
    if (age < 40) return '30s';
    if (age < 50) return '40s';
    return '50plus';
  }

  Future<void> _showNotification(RemoteMessage message) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'health_tips_channel',
      'Health Tips',
      importance: Importance.max,
      priority: Priority.high,
      colorized: true,
    );
    
    await _localNotifications.show(
      0,
      message.notification?.title,
      message.notification?.body,
      const NotificationDetails(android: androidPlatformChannelSpecifics),
    );
  }
}