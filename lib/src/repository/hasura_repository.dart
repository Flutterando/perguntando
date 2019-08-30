import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:hasura_connect/hasura_connect.dart';
import 'package:perguntando/src/shared/models/enums.dart';
import 'package:perguntando/src/shared/models/event/event_model.dart';
import 'package:perguntando/src/shared/models/event/lecture_model.dart';
import 'package:perguntando/src/shared/models/lecture_question_liked_model.dart';
import 'package:perguntando/src/shared/models/lecture_question_model.dart';
import 'package:perguntando/src/shared/models/user_model.dart';

class HasuraRepository extends Disposable {
  final HasuraConnect conn;

  HasuraRepository(this.conn);
  // ---
  Future<UserModel> getUser(UserModel user) async {
    String query = '''getUser(\$email:String!, \$pwd:String!){
                        user(where: {email: {_eq: \$email}, password: {_eq: \$pwd}}) {
                          id
                          name
                          mail
                          info_date
                          photo
                          github_user
                        }
                      }''';

    try {
      var data = await conn
          .query(query, variables: {'email': user.email, 'pwd': user.password});
      // TODO  Verifica se dados do usuario existe
      if (data['data']['user'].isEmpty) {
        throw 'Usuario ou senha invalidos';
      } else {
        return UserModel.fromJson(data['data']['user'][0]);
      }
    } on HasuraError catch (e) {
      print('LOGX ==:>> ERROR[getUser]');
      print(e);
      print(e.extensions);
      print('=================');
      return null;
    }
  }

  //--
  Future<UserModel> createUser(UserModel user) async {
    var query =
        '''mutation createUser(\$name:String!, \$email:String!, \$pwd:String!, \$photo:String!, \$githubUser:String!){
              insert_user(objects: {name: \$name, email: \$email, password: \$pwd, photo: \$photo, github_user: \$githubUser}) {
                returning {
                  id_user
                  info_date
                }
              }
            }''';

    try {
      var data = await conn.mutation(query, variables: {
        'name': user.name,
        'email': user.email,
        'pwd': user.password,
        'photo': user.photo,
        'githubUser': user.githubUser
      });

      user.idUser = data['data']['insert_user']['returning'][0]['id_user'];
      user.infoDate = data['data']['insert_user']['returning'][0]['info_date'];
      return user;
    } on HasuraError catch (e) {
      print('LOGX ==:>> ERROR[createUser]');
      print(e);
      print(e.extensions);
      print('=================');
      return null;
    }
  }

  //--
  Stream<List<EventModel>> getEvents() {
    var query = '''subscription {
                      event(where: {info_status: {_eq: true}}, order_by: {info_date: asc}) {
                        id_event
                        name
                        description
                        url_photo
                        color
                        info_date
                        info_status
                        city
                        state
                        location
                      }
                    }''';
    try {
      Snapshot snapshot = conn.subscription(query);
      return snapshot.stream.map(
        (json) => EventModel.fromJsonList(json['data']['event']),
      );
    } on HasuraError catch (e) {
      print('LOGX ==:>> ERROR[getEvents]');
      print(e);
      print(e.extensions);
      print('=================');
      return null;
    }
  }

  //--
  Stream<List<LectureModel>> getLectures(int idEvent) {
    var query = '''subscription (\$idEvent:Int!){
                    lecture(where: {id_event: {_eq: \$idEvent}}, order_by: {info_date: asc}) {
                      id_lecture
                      name
                      description
                      info_date
                      id_event
                      presenter {
                        name
                        photo
                        email
                        github_user
                        id_user
                      }
                    }
                  }''';
    try {
      Snapshot snapshot =
          conn.subscription(query, variables: {'idEvent': idEvent});
      return snapshot.stream.map(
        (json) => LectureModel.fromJsonList(json['data']['lecture']),
      );
    } on HasuraError catch (e) {
      print('LOGX ==:>> ERROR[getLectures]');
      print(e);
      print(e.extensions);
      print('=================');
      return null;
    }
  }

  //--
  Snapshot<List<LectureQuestionModel>> getQuestionLectures({
    @required LectureModel lecture,
    @required UserModel user,
    FilterQuestionOrdination type,
    int limit = 10,
  }) {

    String orderBy;
    String where;

    if(type == FilterQuestionOrdination.MY_QUESTIONS){
      orderBy = 'lecture_question_likeds_aggregate: {count: desc}';
      where = 'id_user: {_eq: \$id_user}';
    } else if(type == FilterQuestionOrdination.BY_DATE) {
      orderBy = 'info_date: desc';
      where = '';
    } else {
      orderBy = 'lecture_question_likeds_aggregate: {count: desc}';
      where = '';
    }

    var query =
        '''subscription getQuestionLectures(\$id_lecture:Int!, \$id_user:Int!, \$limit: Int!){
                    lecture_question(where: {id_lecture: {_eq: \$id_lecture}, $where}, order_by: {$orderBy}, limit: \$limit) {
                      id_lecture_question
                      id_lecture
                      description
                      info_date
                      id_user
                      user {
                        id
                        name
                        photo
                      }
                      lecture_question_likeds_aggregate {
                        aggregate {
                          count
                        }
                      }
                      lecture_question_likeds(where: {id_user: {_eq: \$id_user}}) {
                        id_lecture_question_liked
                      }
                    } 
                  }''';
    try {
      Snapshot<List<LectureQuestionModel>> snapshot = conn.subscription(query,
          variables: {
            'id_lecture': lecture.idLecture,
            'id_user': user.idUser,
            'limit': limit
          }).map((json) {
        var a =
            LectureQuestionModel.fromJsonList(json['data']['lecture_question']);
        return a;
      });

      return snapshot;
    } on HasuraError catch (e) {
      print('LOGX ==:>> ERROR[getQuestionLectures]');
      print(e);
      print(e.extensions);
      print('=================');
      return null;
    }
  }

  //--
  Future<LectureQuestionModel> createLectureQuestion(LectureQuestionModel lectureQuestion) async {
    var query =
        '''mutation createLectureQuestion(\$id_lecture:Int!, \$id_user:Int!, \$description:String!, \$info_date:timestamptz!){
                      insert_lecture_question(objects: {id_lecture: \$id_lecture, id_user:  \$id_user, description: \$description , info_date: \$info_date }) {
                        returning {
                          id_lecture_question
                          info_date
                        }
                      }
                    }''';
    try {
      var data = await conn.mutation(query, variables: {
        'id_lecture': lectureQuestion.idLecture,
        'id_user': lectureQuestion.idUser,
        'description': lectureQuestion.description,
        'info_date': DateTime.now().toUtc().toString()
      });

      lectureQuestion.idLectureQuestion = data['data']['insert_lecture_question']['returning'][0]['id_lecture_question'];
      lectureQuestion.infoDate =  DateTime.tryParse(data['data']['insert_lecture_question']['returning'][0]['info_date']);
      return lectureQuestion;
    } on HasuraError catch (e) {
      print('LOGX ==:>> ERROR[createLectureQuestion]');
      print(e);
      print(e.extensions);
      print('=================');
      return null;
    }
  }

  Future<bool> deleteLectureQuestion(
      LectureQuestionModel lectureQuestion) async {
    var query = '''mutation deleteLectureQuestion(\$id_lecture_question:Int!){
                    delete_lecture_question(where: {id_lecture_question: {_eq: \$id_lecture_question}}) {
                      affected_rows
                    }
                  }''';
    try {
      await conn.mutation(
        query,
        variables: {'id_lecture_question': lectureQuestion.idLectureQuestion},
      );
      return true;
    } on HasuraError catch (e) {
      print('LOGX ==:>> ERROR[deleteLectureQuestion]');
      print(e);
      print(e.extensions);
      print('=================');
      return false;
    }
  }

  Future<bool> createLectureQuestionLiked(
      Snapshot<List<LectureQuestionModel>> snapshot,
      LectureQuestionModel lectureQuestion,
      int userId) async {
    var query =
        '''mutation createLiked(\$id_lecture_question:Int!, \$id_user:Int!){
                      insert_lecture_question_liked(objects: {id_lecture_question: \$id_lecture_question, id_user: \$id_user , id_lecture_question_liked: 0}) {
                        affected_rows
                      }
                    }''';
    try {
      await snapshot.mutation(query, variables: {
        'id_lecture_question': lectureQuestion.idLectureQuestion,
        'id_user': userId,
      }, onNotify: (data) {
        var finded = data?.firstWhere((dt) =>
            (dt.idLectureQuestion == lectureQuestion.idLectureQuestion));

        finded?.isLiked = true;
        finded?.qtdLike++;

        return data;
      });
      return true;
    } on HasuraError catch (e) {
      print('LOGX ==:>> ERROR[createLiked]');
      print(e);
      print(e.extensions);
      print('=================');
      return false;
    }
  }

  Future<bool> deleteLectureQuestionLiked(
      Snapshot<List<LectureQuestionModel>> snapshot,
      LectureQuestionModel lectureQuestionModel,
      int userId) async {
    var query =
        '''mutation deleteLectureQuestionLiked(\$id_lecture_question:Int!, \$id_user:Int!){
           delete_lecture_question_liked(where: {id_lecture_question: {_eq: \$id_lecture_question}, id_user: {_eq: \$id_user},}) {
              affected_rows
            }          
          }''';

    try {
      await snapshot.mutation(query, variables: {
        'id_lecture_question': lectureQuestionModel.idLectureQuestion,
        'id_user': userId,
      }, onNotify: (data) {
        var finded = data?.firstWhere((dt) =>
            (dt.idLectureQuestion == lectureQuestionModel.idLectureQuestion));

        finded?.isLiked = false;
        finded?.qtdLike--;

        return data;
      });

      return true;
    } on HasuraError catch (e) {
      print('LOGX ==:>> ERROR[deleteLectureQuestionLiked]');
      print(e);
      print(e.extensions);
      print('=================');
      return false;
    }
  }

  @override
  void dispose() {
    conn.dispose();
  }
}
