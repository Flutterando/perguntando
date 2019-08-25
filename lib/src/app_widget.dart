import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:perguntando/src/home/home_module.dart';
import 'package:perguntando/src/shared/models/user_state.dart';
import 'package:perguntando/src/splash/splash_page.dart';

import 'app_module.dart';
import 'login/login_module.dart';
import 'shared/blocs/auth_bloc.dart';

import 'login/login_module.dart';

class AppWidget extends StatelessWidget {
  void _setOrientation() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  void _initOneSignal() {
    OneSignal.shared.init("0f25b644-56f3-4fa2-96bb-f5a72606ebb8");
    OneSignal.shared
        .setInFocusDisplayType(OSNotificationDisplayType.notification);
  }


  @override
  Widget build(BuildContext context) {
    _setOrientation();
    _initOneSignal();
    final bloc = AppModule.to.bloc<AuthBloc>();

    return MaterialApp(
      title: 'Perguntando',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Color(0xFF1565C0),
        backgroundColor: Colors.white,
        scaffoldBackgroundColor: Colors.white,
      ),
      home: SplashPage(), //LoginModule(),
    );
  }
}
