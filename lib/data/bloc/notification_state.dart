part of 'notification_bloc.dart';

@immutable
abstract class NotificationState {
  const NotificationState();
}

class NotificationInitial extends NotificationState {}

class NotificationLoading extends NotificationState {}

class NotificationEnabled extends NotificationState {}

class NotificationDisabled extends NotificationState {}

class NotificationError extends NotificationState {
  final String message;

  const NotificationError(this.message);
}