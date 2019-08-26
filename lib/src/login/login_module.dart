import 'package:perguntando/src/login/pages/email_validation/email_validation_bloc.dart';
import 'package:perguntando/src/app_module.dart';
import 'package:perguntando/src/login/login_bloc.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:perguntando/src/login/login_page.dart';
import 'package:perguntando/src/repository/hasura_repository.dart';
import 'package:perguntando/src/shared/blocs/auth_bloc.dart';

import 'pages/sign_in/sign_in_bloc.dart';
import 'pages/sing_up/sing_up_bloc.dart';

class LoginModule extends ModuleWidget {
  @override
  List<Bloc> get blocs => [
        Bloc((i) => EmailValidationBloc()),
        Bloc((i) => SignInBloc(
              AppModule.to.bloc<AuthBloc>(),
              AppModule.to.get<HasuraRepository>(),
            )),
        Bloc((i) => SingUpBloc()),
        Bloc((i) => LoginBloc()),
      ];

  @override
  List<Dependency> get dependencies => [];

  @override
  Widget get view => LoginPage();

  static Inject get to => Inject<LoginModule>.of();
}
