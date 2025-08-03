import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:health_tips_app/data/bloc/notification_bloc.dart';
import 'package:health_tips_app/data/services/notification_service.dart';

final getIt = GetIt.instance;

@injectableInit
void configureDependencies() {
  
  getIt.registerFactory(() => NotificationBloc(
    notificationService: getIt<NotificationService>()
  ));
  
}