import 'package:perguntando/src/splash/splash_bloc.dart';
import 'package:perguntando/src/shared/blocs/auth_bloc.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:hasura_connect/hasura_connect.dart';
import 'package:perguntando/src/app_widget.dart';
import 'package:perguntando/src/app_bloc.dart';
import 'package:perguntando/src/shared/utils/constants.dart';

import 'repository/hasura_repository.dart';
import 'shared/repositories/custom_hasura_connect.dart';

class AppModule extends ModuleWidget {
  @override
  List<Bloc> get blocs => [
        Bloc((i) => SplashBloc()),
        Bloc((i) => AuthBloc()),
        Bloc((i) => AppBloc()),
      ];

  @override
  List<Dependency> get dependencies => [
        Dependency((i) => HasuraRepository(i.get<CustomHasuraConnect>())),
        Dependency((i) => CustomHasuraConnect(AppModule.to.bloc<AuthBloc>())),
      ];

  @override
  Widget get view => AppWidget();

  static Inject get to => Inject<AppModule>.of();
}
