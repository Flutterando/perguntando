import 'dart:convert';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:dio/dio.dart';
import 'package:perguntando/src/shared/utils/constants.dart';
import 'package:perguntando/src/shared/utils/convert.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthRepository extends Disposable {
  final _dio = Dio();
  Future<Map> getToken(String email, String password,
      {bool isTest = false}) async {
    password = convertMd5(password);
    var base64 = Latin1Codec().fuse(Base64Codec());
    String authToken = base64.encode('$email:$password');
    String credentials = 'Basic $authToken';
    var response = await refreshToken(credentials);
    if (!isTest) {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      sharedPreferences.setString('credentials', credentials);
    }
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

  @override
  void dispose() {}
}
