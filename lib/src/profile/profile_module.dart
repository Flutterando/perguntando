import 'package:perguntando/src/app_module.dart';
import 'package:perguntando/src/profile/profile_bloc.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:perguntando/src/profile/profile_page.dart';
import 'package:perguntando/src/profile/repository/profile_repository.dart';
import 'package:perguntando/src/shared/repositories/auth_repository.dart';
import 'package:perguntando/src/shared/repositories/custom_hasura_connect.dart';
import 'package:perguntando/src/shared/services/authentication_facade.dart';

class ProfileModule extends ModuleWidget {
  @override
  List<Bloc> get blocs => [
        Bloc((i) =>
            ProfileBloc(AppModule.to.getDependency<AuthenticationFacade>())),
      ];

  @override
  List<Dependency> get dependencies => [
        Dependency(
            (i) => ProfileRepository(AppModule.to.get<CustomHasuraConnect>())),
        Dependency((i) => AuthRepository())
      ];

  @override
  Widget get view => const ProfilePage();

  static Inject get to => Inject<ProfileModule>.of();
}
