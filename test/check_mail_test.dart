import 'dart:convert';
import 'package:crypto/crypto.dart' as crypto;
import 'package:convert/convert.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:perguntando/src/shared/models/user_model.dart';
import 'package:perguntando/src/shared/utils/constants.dart';

main() {
  test('Register Test', () async {
    final userModel = UserModel(
      email: 'sr.vasconcelos01@gmail.com',
      name: 'joão test',
      password: '123456789',
    );
    userModel.password = generateMd5(userModel.password);
    final code = DateTime.now().microsecondsSinceEpoch.toString().substring(0,4);
    userModel.code = int.parse(code);
    final _dio = Dio();
    await _dio.post(
      '$API_URL/auth/v1/checkMail',
      data: userModel.toJson(),
    );
  });
}

generateMd5(String data) {
  var content = new Utf8Encoder().convert(data);
  var md5 = crypto.md5;
  var digest = md5.convert(content);
  return hex.encode(digest.bytes);
}
