import 'dart:convert';
import 'package:crypto/crypto.dart' as crypto;
import 'package:convert/convert.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:perguntando/src/shared/models/user_model.dart';
import 'package:perguntando/src/shared/utils/constants.dart';
import 'package:perguntando/src/shared/utils/convert.dart';

main() {
  test('Check email test', () async {
    final userModel = UserModel(
      email: 'sr.vasconcelos01@gmail.com',
      name: 'joão test',
      password: '123456789',
    );
    userModel.password = convertMd5(userModel.password);
    final code = DateTime.now().microsecondsSinceEpoch.toString().substring(0,4);
    userModel.code = int.parse(code);
    final _dio = Dio();
    final response = await _dio.post(
      '$API_URL/auth/v1/checkMail',
      data: userModel.toJson(),
    );
    print(response.data);
  });
}

