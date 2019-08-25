import 'package:perguntando/src/profile/profile_bloc.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:perguntando/src/profile/profile_page.dart';

class ProfileModule extends ModuleWidget {
  @override
  List<Bloc> get blocs => [
        Bloc((i) => ProfileBloc()),
      ];

  @override
  List<Dependency> get dependencies => [];

  @override
  Widget get view => ProfilePage();

  static Inject get to => Inject<ProfileModule>.of();
}
