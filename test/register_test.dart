import 'package:flutter_test/flutter_test.dart';
import 'package:hasura_connect/hasura_connect.dart';
import 'package:perguntando/src/repository/hasura_repository.dart';
import 'package:perguntando/src/shared/models/user_model.dart';
import 'package:perguntando/src/shared/utils/constants.dart';

main() {
  test('Register Test', () async {
    final user = User(
      email: 'alvaro@flutterando.com.br',
      name: 'Alvaro Vasconcelos',
     
    );
    HasuraConnect hasuraConnect = HasuraConnect(HASURA_URL,
        headers: {'x-hasura-admin-secret': 'flutterando@2019'});
    HasuraRepository authRepository = HasuraRepository(hasuraConnect);
    var token = await authRepository.createUser(user);
    print(token);
  });
}
