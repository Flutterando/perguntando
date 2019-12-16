import 'package:dio/dio.dart';
import 'package:perguntando/src/shared/models/user_model.dart';
import 'package:perguntando/src/shared/utils/constants.dart';

abstract class IAuthenticationRepository {
  Future<LoginResponse> refreshToken(String credentials);
}

class AuthenticationRepository implements IAuthenticationRepository {
  final _dio = Dio();

  Future<LoginResponse> refreshToken(String credentials) async {
    final routerToken = '/auth/v1/gettoken';
    final response = await _dio.post(
      API_URL + routerToken,
      options: Options(
        headers: {'Authorization': credentials},
      ),
    );
    return LoginResponse.fromJson(response.data);
  }
}

class LoginResponse {
  String token;
  User user;

  LoginResponse.fromJson(Map<String, dynamic> json) {
    token = json["token"];
    user = User.fromJson(json["user"]);
  }
}
