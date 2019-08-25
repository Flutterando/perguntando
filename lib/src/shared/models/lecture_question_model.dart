import 'user_model.dart';

class LectureQuestionModel {
  int idLectureQuestion;
  int idLecture;
  int idUser;
  String description;
  DateTime infoDate;
  UserModel user;
  int qtdLike;
  bool isLiked;

  LectureQuestionModel(
      {this.idLectureQuestion,
      this.idLecture,
      this.idUser,
      this.description,
      this.infoDate,
      this.user,
      this.qtdLike,
      this.isLiked});

  LectureQuestionModel.fromJson(Map<String, dynamic> json) {
    idLectureQuestion = json['id_lecture_question'];
    idLecture = json['id_lecture'];
    idUser = json['id_user'];
    description = json['description'];
    infoDate = DateTime.tryParse(json['info_date']);
    user = UserModel.fromJson(json['user']);
    qtdLike = json['lecture_question_likeds_aggregate']['aggregate']['count'];
    isLiked = (json['lecture_question_likeds'].length == 0)? false: true; 
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id_lecture_question'] = this.idLectureQuestion;
    data['id_lecture'] = this.idLecture;
    data['id_user'] = this.idUser;
    data['description'] = this.description;
    data['info_date'] = this.infoDate;
    data['user']= this.user.toJson();
    data['qtd_like'] = (this.qtdLike) ?? 0;
    data['is_liked'] = (this.isLiked) ?? false; 
    return data;
  }

  static List<LectureQuestionModel> fromJsonList(List list) {
    if (list == null) return null;
    return list.map((item) => LectureQuestionModel.fromJson(item)).toList();
  }

  @override
  String toString() {
    return '${this.toJson()}';
  }
}
