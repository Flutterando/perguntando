class UpdateUserDto {
  final int userId;
  final String name;
  final String email;
  final String password;

  UpdateUserDto(this.name, this.password, this.email, this.userId);

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (name != null && name.isNotEmpty) json["name"] = name;
    if (password != null && password.isNotEmpty) json["password"] = password;
    return json;
  }
}
