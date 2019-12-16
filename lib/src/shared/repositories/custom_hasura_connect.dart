import 'package:hasura_connect/hasura_connect.dart';
import 'package:perguntando/src/shared/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomHasuraConnect extends HasuraConnect {
  CustomHasuraConnect()
      : super(HASURA_URL, token: _validToken);

  static Future<String> _validToken(bool isError) async {
    SharedPreferences _sharedPreferences =
        await SharedPreferences.getInstance();
    if (_sharedPreferences.containsKey('token')) {
      String token = _sharedPreferences.get('token');
      return 'Bearer $token';
    } else {
      // retorna para a tela do login com erro.
    }
  }
}
