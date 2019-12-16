import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';
import 'package:perguntando/src/app_module.dart';
import 'package:perguntando/src/home/home_module.dart';
import 'package:perguntando/src/login/login_module.dart';
import 'package:perguntando/src/shared/blocs/authentication_bloc.dart';

class RootPage extends StatefulWidget {
  const RootPage({Key key}) : super(key: key);
  @override
  _RootPageState createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  AuthenticationBloc _authenticationBloc;

  @override
  void initState() {
    super.initState();
    _authenticationBloc = AppModule.to.bloc<AuthenticationBloc>();
  }

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (_) {
      final response = _authenticationBloc.initialAuthenticated;
      final status = response.status;

      if (status == FutureStatus.fulfilled) {
        if (response.value == null) {
          return LoginModule();
        }
        return HomeModule();
      } else {
        return Scaffold(
          body: const Center(
            child: CircularProgressIndicator(),
          ),
        );
      }
    });
  }
}
