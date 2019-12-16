import 'package:perguntando/src/app_module.dart';
import 'package:perguntando/src/login/login_bloc.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:perguntando/src/login/login_page.dart';
import 'package:perguntando/src/login/pages/page_register/sign_up_bloc.dart';
import 'package:perguntando/src/shared/services/authentication_facade.dart';
import 'pages/sign_in/sign_in_bloc.dart';

class LoginModule extends ModuleWidget {
  @override
  List<Bloc> get blocs => [
        Bloc((i) => SignInBloc(
              AppModule.to.getDependency<AuthenticationFacade>(),
            )),
        Bloc((i) => SignUpBloc()),
        Bloc((i) => SplashBloc()),
      ];

  @override
  List<Dependency> get dependencies => [];

  @override
  Widget get view => const LoginPage();

  static Inject get to => Inject<LoginModule>.of();
}
