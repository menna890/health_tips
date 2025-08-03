import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_tips_app/core/di/injection.dart';
import 'package:health_tips_app/data/bloc/notification_bloc.dart';
import 'package:health_tips_app/presentation/user_profile_page.dart';

class HealthTipsApp extends StatelessWidget {
  const HealthTipsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Daily Health Tips',
      debugShowCheckedModeBanner: false,
      home: BlocProvider(
  create: (context) => getIt<NotificationBloc>(),
  child: UserProfilePage(),
  )
    );
  }
}
