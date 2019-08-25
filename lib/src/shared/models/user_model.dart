class UserModel {
  int idUser;
  String name;
  String email;
  String password;
  String infoDate;
  String photo;
  String githubUser;

  UserModel(
      {this.idUser,
      this.name,
      this.email,
      this.infoDate,
      this.photo,
      this.githubUser,
      this.password});

  UserModel.fromJson(Map<String, dynamic> json) {
    idUser = json['id'];
    name = json['name'];
    email = json['mail'];
    infoDate = json['info_date'];
    photo = json['photo'];
    githubUser = json['github_user'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.idUser;
    data['name'] = this.name;
    data['mail'] = this.email;
    data['password'] = this.password;
    data['info_date'] = this.infoDate;
    data['photo'] = this.photo;
    data['github_user'] = this.githubUser;
    return data;
  }

  @override
  String toString() {
    return '${this.toJson()}';
  }
}
