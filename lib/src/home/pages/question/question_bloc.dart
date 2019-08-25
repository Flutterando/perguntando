import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:hasura_connect/hasura_connect.dart';
import 'package:perguntando/src/repository/hasura_repository.dart';
import 'package:perguntando/src/shared/models/event/lecture_model.dart';
import 'package:perguntando/src/shared/models/lecture_question_liked_model.dart';
import 'package:perguntando/src/shared/models/lecture_question_model.dart';
import 'package:perguntando/src/shared/models/user_model.dart';
import 'package:rxdart/rxdart.dart';

class QuestionBloc extends BlocBase {
  final String tag;
  final LectureModel lecture;
  final HasuraRepository _hasuraRepository;
  final UserModel user;
  Snapshot<List<LectureQuestionModel>> _getLectures ;
  QuestionBloc(this.tag, this.lecture, this._hasuraRepository, this.user) {
    _getLectures = _hasuraRepository.getQuestionLectures(lecture: lecture, user: user);
  }

  Observable<List<LectureQuestionModel>> get questions =>
      Observable(_getLectures.stream);

  Future<bool> deleteLectureQuestion(
      LectureQuestionModel lectureQuestion) async {
    return await _hasuraRepository.deleteLectureQuestion(lectureQuestion);
  }  

  Future<bool> like(LectureQuestionModel lectureQuestion) async {
    return await _hasuraRepository.createLectureQuestionLiked(_getLectures,
        lectureQuestion, user.idUser);
  }

  Future<bool> dislike(LectureQuestionModel lectureQuestionLikedModel) async {
    return await _hasuraRepository.deleteLectureQuestionLiked(_getLectures,
        lectureQuestionLikedModel, user.idUser);
  }

  //dispose will be called automatically by closing its streams
  @override
  void dispose() {
    super.dispose();
  }
}
