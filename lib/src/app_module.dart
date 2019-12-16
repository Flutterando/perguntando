import 'package:perguntando/src/shared/blocs/authentication_bloc.dart';
import 'package:perguntando/src/shared/models/credential_store.dart';
import 'package:perguntando/src/shared/models/iauth_repository.dart';
import 'package:perguntando/src/shared/models/notification_store.dart';
import 'package:perguntando/src/shared/models/token_store.dart';
import 'package:perguntando/src/shared/models/user_store.dart';
import 'package:perguntando/src/shared/notification/notification_app.dart';
import 'package:perguntando/src/shared/notification/notification_bloc.dart';
import 'package:perguntando/src/shared/services/authentication_facade.dart';
import 'package:perguntando/src/shared/services/credential_converter.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:perguntando/src/app_widget.dart';
import 'repository/hasura_repository.dart';
import 'shared/repositories/custom_hasura_connect.dart';

class AppModule extends ModuleWidget {
  @override
  List<Bloc> get blocs => [
        Bloc((i) => AuthenticationBloc(
            AppModule.to.getDependency<AuthenticationFacade>())),
        Bloc((i) => NotificationBloc())
      ];

  @override
  List<Dependency> get dependencies => [
        Dependency(
          (i) => AuthenticationFacade(
              AuthenticationRepository(),
              SharedPreferencesUserStore(),
              CredentialStore(),
              SharedPreferencesTokenStore(),
              AppModule.to.getDependency<NotificationApp>(),
              SharedPreferencesNotificationStore(),
              AccessTokenConverter(),
              null),
        ),
        Dependency((i) => HasuraRepository(i.get<CustomHasuraConnect>())),
        Dependency((i) => CustomHasuraConnect()),
        Dependency((i) => NotificationApp())
      ];

  @override
  Widget get view => const AppWidget();

  static Inject get to => Inject<AppModule>.of();
}
