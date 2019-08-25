import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:perguntando/src/home/pages/question/question_bloc.dart';
import 'package:perguntando/src/repository/hasura_repository.dart';
import 'package:perguntando/src/shared/models/lecture_question_model.dart';

class NewQuestionBloc extends BlocBase {
  final HasuraRepository repository;
  final QuestionBloc questionBloc;

  var perguntaTextController = TextEditingController();

  NewQuestionBloc(this.repository, this.questionBloc);

  @override
  void dispose() {
    super.dispose();
  }

  Future<bool> sendMessage() async {
    try {
     var result =  await repository.createLectureQuestion(LectureQuestionModel(idUser: questionBloc.user.idUser, idLecture: questionBloc.lecture.idLecture , description: perguntaTextController.text ));  
     return result != null;
    } catch (e) {
      
    }
    return false;
  }
}
