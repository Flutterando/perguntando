import 'package:perguntando/src/home/pages/new_question/new_question_bloc.dart';
import 'package:perguntando/src/home/pages/question/question_bloc.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:perguntando/src/home/pages/question/question_page.dart';
import 'package:perguntando/src/repository/hasura_repository.dart';
import 'package:perguntando/src/shared/blocs/auth_bloc.dart';
import 'package:perguntando/src/shared/models/event/lecture_model.dart';

import '../../../app_module.dart';

class QuestionModule extends ModuleWidget {
  final String tag;
  final LectureModel lecture;

  QuestionModule( {this.tag, this.lecture});
  @override
  List<Bloc> get blocs => [
        Bloc((i) => QuestionBloc(tag,lecture,AppModule.to.getDependency<HasuraRepository>(), AppModule.to.bloc<AuthBloc>().userControleValue )),
        Bloc((i) => NewQuestionBloc(AppModule.to.getDependency<HasuraRepository>() , i.bloc<QuestionBloc>())),
      ];

  @override
  List<Dependency> get dependencies => [
     
  ];

  @override
  Widget get view => QuestionPage();

  static Inject get to => Inject<QuestionModule>.of();
}
