import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:perguntando/src/shared/models/user_model.dart';
import 'package:perguntando/src/shared/utils/constants.dart';
import 'package:perguntando/src/shared/utils/convert.dart';

main() {
  test('Registro test', () async {
    final userModel = UserModel(
      email: 'sr.vasconcelos01@gmail.com',
      name: 'Alvarinho',
      password: '123456789',
    );
    userModel.password = convertMd5(userModel.password);
    final _dio = Dio();
    final response = await _dio.post(
      '$API_URL/auth/v1/register',
      data: userModel.toJson(),
    );
    print(response.data);
  });
}


