import 'dart:convert';
import 'package:convert/convert.dart';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:crypto/crypto.dart' as crypto;
import 'package:dio/dio.dart';
import 'package:perguntando/src/shared/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthRepository extends Disposable {
  final _dio = Dio();
  
  Future<Map> getToken(String email, String password) async {
    password = generateMd5(password);
    var base64 = Latin1Codec().fuse(Base64Codec());
    String authToken = base64.encode('$email:$password');
    String credentials = 'Basic $authToken';
    var response = await refreshToken(credentials);
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString('credentials', credentials);
    return response.data;
  }

  Future<Response> refreshToken(String credentials) {
    final routerToken = '/auth/v1/gettoken';
    return _dio.post(
      API_URL + routerToken,
      options: Options(
        headers: {'Authorization': credentials},
      ),
    );
  }

  String generateMd5(String data) {
    var content = new Utf8Encoder().convert(data);
    var md5 = crypto.md5;
    var digest = md5.convert(content);
    return hex.encode(digest.bytes);
  }

  @override
  void dispose() {}
}
