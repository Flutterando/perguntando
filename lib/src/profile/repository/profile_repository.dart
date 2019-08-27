import 'dart:convert';
import 'dart:developer';
import 'package:hasura_connect/hasura_connect.dart';
import 'package:perguntando/src/app_module.dart';
import 'package:perguntando/src/shared/blocs/auth_bloc.dart';
import 'package:perguntando/src/shared/repositories/custom_hasura_connect.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileRepository {
  final CustomHasuraConnect _customHasuraConnect;
  ProfileRepository(this._customHasuraConnect);

  Future<void> updateUser(ProfileDto profileDto) async {
    try {
     
      final passwordField =
          profileDto.password.isNotEmpty ? " password: \$password," : '';

      final passwordValue =
          profileDto.password.isNotEmpty ? "\$password:String!," : '';

      final nameField = profileDto.name.isNotEmpty ? " name: \$name, " : '';
      final nameValue = profileDto.name.isNotEmpty ? " \$name:String!, " : '';

      final prefs = await SharedPreferences.getInstance();
      final authBloc = AppModule.to.getBloc<AuthBloc>();
      final user = authBloc.userControleValue;

      String doc = '''
     mutation ($nameValue $passwordValue){
      update_users(_set: {$nameField $passwordField}, where: {id: {_eq: ${user.idUser}}}) {
      returning {
        name
          }
        }
      }
      ''';
      print("${doc}");

      print(profileDto.toJson());

      await _customHasuraConnect.mutation(doc, variables: profileDto.toJson());

      final base64 = Latin1Codec().fuse(Base64Codec());
      final authToken = base64.encode('${user.email}:${profileDto.password}');

      final credentials = 'Basic $authToken';
      prefs.setString('credentials', credentials);

      user.name = profileDto.name;
      
      authBloc.inUser.add(user);

    } on HasuraError catch (e) {
      log("$e");
      rethrow;
    } catch (e) {
      log("$e");
      rethrow;
    }
  }
}

class ProfileDto {
  final String name;
  final String password;

  ProfileDto(this.name, this.password);

  Map<String, dynamic> toJson(){
   final json = <String,dynamic>{};
   if(name != null && name.isNotEmpty)
   json["name"] = name;
    if(password != null && password.isNotEmpty)
   json["password"] = password;
   return json;
  }
  
}
