import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:perguntando/src/login/login_module.dart';
import 'package:perguntando/src/login/pages/sign_up/sign_up_bloc.dart';
import 'package:perguntando/src/shared/utils/constants.dart';
import 'package:rxdart/rxdart.dart';
import 'package:rxdart/subjects.dart';

import '../../login_bloc.dart';

class CheckMailBloc extends BlocBase {
  final signUpBloc = LoginModule.to.bloc<SignUpBloc>();
  final loginBloc = LoginModule.to.bloc<LoginBloc>();
  final _erroController = BehaviorSubject<String>();
  Observable<String> get outError => _erroController.stream;

  Future<bool> onRegisterUser() async {
    final userRegister = signUpBloc.userRegister;
    try {
      final _dio = Dio();
      final response = await _dio.post(
        '$API_URL/auth/v1/register',
        data: userRegister.toJson(),
      );
     
      print(response.data);
      return true;
    } on DioError catch (e) {
      _erroController.addError(e.message);
      return false;
    }
  }

  void dispose() {
    _erroController.close();
    super.dispose();
  }
}
