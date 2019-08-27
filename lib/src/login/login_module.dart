import 'package:perguntando/src/app_module.dart';
import 'package:perguntando/src/login/login_bloc.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:perguntando/src/login/login_page.dart';
import 'package:perguntando/src/repository/hasura_repository.dart';
import 'package:perguntando/src/shared/blocs/auth_bloc.dart';

import 'pages/check_mail/check_mail_bloc.dart';
import 'pages/sign_in/sign_in_bloc.dart';
import 'pages/sign_up/sign_up_bloc.dart';

class LoginModule extends ModuleWidget {
  @override
  List<Bloc> get blocs => [
        Bloc((i) => SignInBloc(i.bloc<AuthBloc>(), i.get<HasuraRepository>())),
        Bloc((i) => SignUpBloc()),
        Bloc((i) => LoginBloc()),
        Bloc((i) => CheckMailBloc()),
        Bloc((i) => AppModule.to.bloc<AuthBloc>())
      ];

  @override
  List<Dependency> get dependencies =>
      [Dependency((i) => AppModule.to.get<HasuraRepository>())];

  @override
  Widget get view => LoginPage();

  static Inject get to => Inject<LoginModule>.of();
}
