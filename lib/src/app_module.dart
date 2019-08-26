
import 'package:perguntando/src/shared/notification/notification_app.dart';
import 'package:perguntando/src/shared/notification/notification_bloc.dart';
import 'package:perguntando/src/splash/splash_bloc.dart';
import 'package:perguntando/src/shared/blocs/auth_bloc.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:perguntando/src/app_widget.dart';
import 'package:perguntando/src/app_bloc.dart';
import 'repository/hasura_repository.dart';
import 'shared/repositories/custom_hasura_connect.dart';

class AppModule extends ModuleWidget {
  @override
  List<Bloc> get blocs => [
        Bloc((i) => SplashBloc()),
        Bloc((i) => AuthBloc()),
        Bloc((i) => AppBloc()),
        Bloc((i) => NotificationBloc())
      ];

  @override
  List<Dependency> get dependencies => [
        Dependency((i) => HasuraRepository(i.get<CustomHasuraConnect>())),
        Dependency((i) => CustomHasuraConnect(AppModule.to.bloc<AuthBloc>())),
        Dependency((i) => NotificationApp())
      ];

  @override
  Widget get view => AppWidget();

  static Inject get to => Inject<AppModule>.of();
}
