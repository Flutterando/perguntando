import 'dart:developer';
import 'package:hasura_connect/hasura_connect.dart';
import 'package:perguntando/src/profile/models/profile_dto.dart';
import 'package:perguntando/src/shared/repositories/custom_hasura_connect.dart';


abstract class IProfileRepository {
  Future<void> update(UpdateUserDto profileDto);
}

class ProfileRepository implements IProfileRepository {
  final CustomHasuraConnect _customHasuraConnect;
  ProfileRepository(this._customHasuraConnect);

  Future<void> update(UpdateUserDto profileDto) async {
    try {
      final doc = profileDto.password.isEmpty
          ? updateUserQuery
          : updateUserAndPasswordQuery;
      await _customHasuraConnect.mutation(doc, variables: profileDto.toJson());
    } on HasuraError catch (e) {
      log("$e");
      rethrow;
    } catch (e) {
      log("$e");
      rethrow;
    }
  }
}

String updateUserQuery = '''
     mutation (\$name:String!){
      update_users(_set: {\$name}, where: {id: {_eq: \$userId}}) {
      returning {
        name
          }
        }
      }
      ''';

String updateUserAndPasswordQuery = '''
     mutation (\$name:String!,\$password:String!){
      update_users(_set: {\$name,\$password}, where: {id: {_eq: \$userId}}) {
      returning {
        name
          }
        }
      }
      ''';
