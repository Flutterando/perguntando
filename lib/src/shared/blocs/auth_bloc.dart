import 'dart:async';
import 'dart:convert';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:dio/dio.dart';
import 'package:perguntando/src/app_module.dart';

import 'package:perguntando/src/shared/models/user_model.dart';
import 'package:perguntando/src/shared/models/user_state.dart';
import 'package:perguntando/src/shared/notification/notification_app.dart';
import 'package:perguntando/src/shared/repositories/auth_repository.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthBloc extends BlocBase {
  final _userController = BehaviorSubject<UserModel>();
  final authRepository = AuthRepository();
  final _userStateController =
      BehaviorSubject<AuthState>.seeded(NotAuthenticated());
  StreamSubscription tokenSub;

  Observable<AuthState> get outUserState => _userStateController.stream;
  Sink<AuthState> get inUserState => _userStateController.sink;

  Observable<UserModel> get outUser => _userController.stream;
  Sink<UserModel> get inUser => _userController.sink;
  UserModel get userControleValue => _userController.value;

  Future<bool> isLogin() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    if (sharedPreferences.containsKey('user')) {
      try {
        String credentials = sharedPreferences.get('credentials');
        Response response = await authRepository.refreshToken(credentials);
        String token = response.data['token'];
        print(token);
        UserModel userModel = UserModel.fromJson(response.data['user']);
        _userController.add(userModel);
        sharedPreferences.setString('token', token);
        sharedPreferences.setString('user', jsonEncode(userModel.toJson()));
       await AppModule.to.getDependency<NotificationApp>().setEmail(email: userModel.email);
        return true;
      } catch (e) {
        return false;
      }
    } else {
      return false;
    }
  }

  Future<void> logOff() async {
    try {
      _userController.add(null);
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      await sharedPreferences.remove('user');
      await sharedPreferences.remove('token');
      await sharedPreferences.remove('credentials');
      AppModule.to.getDependency<NotificationApp>().logoutEmail();
    } catch (e) {}
  }

  @override
  void dispose() {
    tokenSub.cancel();
    _userStateController.close();
    _userController.close();
    super.dispose();
  }
}
