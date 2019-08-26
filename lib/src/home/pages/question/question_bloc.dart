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
  
  int page;

  Snapshot<List<LectureQuestionModel>> _snapshot;

  QuestionBloc(this.tag, this.lecture, this._hasuraRepository, this.user) {
    page = 2;
    _snapshot = _hasuraRepository.getQuestionLectures(lecture: lecture, user: user);
    _snapshot.changeVariable({
      'id_lecture': lecture.idLecture,
      'id_user': user.idUser,
      'limit': page * 10,
    });
  }

  Observable<List<LectureQuestionModel>> get questions => Observable(_snapshot.stream);

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

  final BehaviorSubject<String> typeStream = BehaviorSubject<String>.seeded('c');
  String get numberQuestion => typeStream.value; 
  Sink<String> get numberQuestionIn => typeStream.sink;
  Observable<String> get numberQuestionOut =>  typeStream.stream;

  // ANCHOR  d - Data | c - Mais curtidas | p - Minhas perguntas
  void filter(String type) {
    page = 2;
    _snapshot = _hasuraRepository.getQuestionLectures(lecture: lecture, user: user, type: type);
    _snapshot.changeVariable({
      'id_lecture': lecture.idLecture,
      'id_user': user.idUser,
      'limit': page * 10,
    });
  }

  @override
  void dispose() {
    typeStream.close();
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
