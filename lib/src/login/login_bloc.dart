import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
class SplashBloc extends BlocBase {
  PageController pageController = PageController();

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }
}
