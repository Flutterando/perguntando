import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:hasura_connect/hasura_connect.dart';
import 'package:perguntando/src/repository/hasura_repository.dart';
import 'package:perguntando/src/shared/models/event/lecture_model.dart';
import 'package:perguntando/src/shared/models/lecture_question_model.dart';
import 'package:perguntando/src/shared/models/user_model.dart';
import 'package:rxdart/rxdart.dart';

class QuestionBloc extends BlocBase {
  final String tag;
  final LectureModel lecture;
  final HasuraRepository _hasuraRepository;
  final UserModel user;
  int page = 2;

  Snapshot<List<LectureQuestionModel>> _snapshot;

  QuestionBloc(this.tag, this.lecture, this._hasuraRepository, this.user) {
    _snapshot =
        _hasuraRepository.getQuestionLectures(lecture: lecture, user: user);
  }

  Observable<List<LectureQuestionModel>> get questions =>
      Observable(_snapshot.stream);

  Future<bool> deleteLectureQuestion(
      LectureQuestionModel lectureQuestion) async {
    return await _hasuraRepository.deleteLectureQuestion(lectureQuestion);
  }

  Future<bool> like(LectureQuestionModel lectureQuestion) async {
    return await _hasuraRepository.createLectureQuestionLiked(
        _snapshot, lectureQuestion, user.idUser);
  }

  Future<bool> dislike(LectureQuestionModel lectureQuestionLikedModel) async {
    return await _hasuraRepository.deleteLectureQuestionLiked(
        _snapshot, lectureQuestionLikedModel, user.idUser);
  }

  @override
  void dispose() {
    super.dispose();
  }

  void getMoreQuestions() {
    print(page);
    _snapshot.changeVariable({
      'id_lecture': lecture.idLecture,
      'id_user': user.idUser,
      'limit': page * 10,      
    });
    page++;
  }
}
