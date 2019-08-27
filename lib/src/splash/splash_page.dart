import 'package:flutter/material.dart';
import 'package:perguntando/src/app_module.dart';
import 'package:perguntando/src/home/home_module.dart';
import 'package:perguntando/src/login/login_module.dart';
import 'package:perguntando/src/shared/blocs/auth_bloc.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  checkLogin() async {
    var authBloc = AppModule.to.bloc<AuthBloc>();
    if (await authBloc.isLogin()) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => HomeModule(),
        ),
      );
    } else {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => LoginModule(),
        ),
      );
    }
  }
  
  @override
  void initState() {
    super.initState();
    checkLogin();
  }

  @override
  Widget build(BuildContext context) {

    return Material(
      color: Theme.of(context).primaryColor,
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
