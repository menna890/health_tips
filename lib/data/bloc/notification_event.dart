part of 'notification_bloc.dart';

@immutable
abstract class NotificationEvent {
  const NotificationEvent();
}

class EnableNotifications extends NotificationEvent {
  final int age;
  final String fitnessGoal;

  const EnableNotifications({
    required this.age,
    required this.fitnessGoal,
  });
}

class DisableNotifications extends NotificationEvent {
  const DisableNotifications();
}