class User {
  int id;
  String name;
  String email;
  String password;
  String infoDate;
  String photo;
  String githubUser;

  User(
      {this.id,
      this.name,
      this.email,
      this.infoDate,
      this.photo,
      this.githubUser});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['mail'];
    infoDate = json['info_date'];
    photo = json['photo'];
    githubUser = json['github_user'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['mail'] = this.email;
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