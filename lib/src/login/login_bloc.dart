import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';

class LoginBloc extends BlocBase {
  PageController pageController = PageController();
  final scaffoldKeySingInPage =GlobalKey<ScaffoldState>();

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }
}
