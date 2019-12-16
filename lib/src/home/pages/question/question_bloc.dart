import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:hasura_connect/hasura_connect.dart';
import 'package:perguntando/src/repository/hasura_repository.dart';
import 'package:perguntando/src/shared/models/enums.dart';
import 'package:perguntando/src/shared/models/event/lecture_model.dart';
import 'package:perguntando/src/shared/models/lecture_question_model.dart';
import 'package:perguntando/src/shared/models/user_model.dart';
import 'package:rxdart/rxdart.dart';

class QuestionBloc extends BlocBase {
  final String tag;
  final LectureModel lecture;
  final HasuraRepository _hasuraRepository;
  final User user;

  int page;

  Snapshot<List<LectureQuestionModel>> _likeMoreSnapshot;
  Snapshot<List<LectureQuestionModel>> _byDateSnapshot;
  Snapshot<List<LectureQuestionModel>> _myQuestionsSnapshot;

  Map<String, dynamic> _listagemInicial;

  QuestionBloc(this.tag, this.lecture, this._hasuraRepository, this.user) {
    page = 2;

    _listagemInicial = {
      'id_lecture': lecture.idLecture,
      'id_user': user.id,
      'limit': 1 * 10,
    };

    _likeMoreSnapshot = _hasuraRepository.getQuestionLectures(
        lecture: lecture, user: user, type: FilterQuestionOrdination.LIKE_MORE);
    _byDateSnapshot = _hasuraRepository.getQuestionLectures(
        lecture: lecture, user: user, type: FilterQuestionOrdination.BY_DATE);
    _myQuestionsSnapshot = _hasuraRepository.getQuestionLectures(
        lecture: lecture,
        user: user,
        type: FilterQuestionOrdination.MY_QUESTIONS);
  }

  Future<bool> deleteLectureQuestion(
      LectureQuestionModel lectureQuestion) async {
    return await _hasuraRepository.deleteLectureQuestion(lectureQuestion);
  }

  Future<bool> like(LectureQuestionModel lectureQuestion) async {
    return await _hasuraRepository.createLectureQuestionLiked(
        _byDateSnapshot, lectureQuestion, user.id);
  }

  Future<bool> dislike(LectureQuestionModel lectureQuestionLikedModel) async {
    return await _hasuraRepository.deleteLectureQuestionLiked(
        _byDateSnapshot, lectureQuestionLikedModel, user.id);
  }

  final BehaviorSubject<FilterQuestionOrdination> filterStream =
      BehaviorSubject<FilterQuestionOrdination>.seeded(
          FilterQuestionOrdination.BY_DATE);
  FilterQuestionOrdination get filter => filterStream.value;
  Sink<FilterQuestionOrdination> get filterIn => filterStream.sink;

  Observable<FilterQuestionOrdination> get typeFilterOut => filterStream.stream;
  Observable<List<LectureQuestionModel>> get filterOut =>
      filterStream.stream.where((data) => data != null).switchMap(mappers);

  Stream<List<LectureQuestionModel>> mappers(
      FilterQuestionOrdination data) async* {
    switch (data) {
      case FilterQuestionOrdination.LIKE_MORE:
        yield* _likeMoreSnapshot.stream;
        break;
      case FilterQuestionOrdination.BY_DATE:
        yield* _byDateSnapshot.stream;
        break;
      case FilterQuestionOrdination.MY_QUESTIONS:
        yield* _myQuestionsSnapshot.stream;
        break;
    }
  }

  void setFilter(FilterQuestionOrdination type) {
    filterStream.add(type);
    _likeMoreSnapshot.changeVariable(_listagemInicial);
    _byDateSnapshot.changeVariable(_listagemInicial);
    _myQuestionsSnapshot.changeVariable(_listagemInicial);
  }

  @override
  void dispose() {
    filterStream.close();
    super.dispose();
  }

  void getMoreQuestions() {
    Map<String, dynamic> variable = {
      'id_lecture': lecture.idLecture,
      'id_user': user.id,
      'limit': page * 10,
    };

    switch (filter) {
      case FilterQuestionOrdination.LIKE_MORE:
        _likeMoreSnapshot.changeVariable(variable);
        break;
      case FilterQuestionOrdination.BY_DATE:
        _byDateSnapshot.changeVariable(variable);
        break;
      case FilterQuestionOrdination.MY_QUESTIONS:
        _myQuestionsSnapshot.changeVariable(variable);
        break;
    }
    page++;
  }
}
