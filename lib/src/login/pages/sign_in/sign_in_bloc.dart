import 'dart:convert';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:perguntando/src/repository/hasura_repository.dart';

import 'package:perguntando/src/shared/blocs/auth_bloc.dart';
import 'package:perguntando/src/shared/models/user_model.dart';
import 'package:perguntando/src/shared/models/user_state.dart';
import 'package:perguntando/src/shared/repositories/auth_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignInBloc extends BlocBase {
  final HasuraRepository _hasuraRepository;
  final AuthBloc _authBloc;
  final formKey = GlobalKey<FormState>();

  String email;
  String password;

  SignInBloc(this._authBloc, this._hasuraRepository);

  Future<bool> onLogin() async {
    SharedPreferences _sharedPreferences =
        await SharedPreferences.getInstance();
    FormState _formState = formKey.currentState;
    if (_formState.validate()) {
      _formState.save();
      _authBloc.inUserState.add(Loading());
      AuthRepository authRepository = AuthRepository();
      try {
        var response = await authRepository.getToken(email, password);
        _sharedPreferences.setString('token', response['token']);
        _sharedPreferences.setString('user', jsonEncode(response['user']));
        final user = UserModel.fromJson(response['user']);
        _authBloc.inUser.add(user);
        return true;
      } on DioError catch (e) {
        _authBloc.inUserState.add(Error(e));
      }
    }
    return false;
  }

  @override
  void dispose() {
    super.dispose();
  }
}
