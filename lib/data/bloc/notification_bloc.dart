import 'package:bloc/bloc.dart';
import 'package:health_tips_app/data/services/notification_service.dart';
import 'package:meta/meta.dart';

part 'notification_event.dart';
part 'notification_state.dart';

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  final NotificationService notificationService;

  NotificationBloc({required this.notificationService}) 
    : super(NotificationInitial()) {
    
    on<EnableNotifications>(_onEnableNotifications);
    on<DisableNotifications>(_onDisableNotifications);
  }

  Future<void> _onEnableNotifications(
    EnableNotifications event,
    Emitter<NotificationState> emit,
  ) async {
    emit(NotificationLoading());
    try {
      await notificationService.initialize();
      await notificationService.subscribeToTopics(
        event.age, 
        event.fitnessGoal
      );
      emit(NotificationEnabled());
    } catch (e) {
      emit(NotificationError(e.toString()));
    }
  }

  Future<void> _onDisableNotifications(
    DisableNotifications event,
    Emitter<NotificationState> emit,
  ) async {
    emit(NotificationLoading());
    try {
      await notificationService.unsubscribeFromAllTopics();
      emit(NotificationDisabled());
    } catch (e) {
      emit(NotificationError(e.toString()));
    }
  }
}