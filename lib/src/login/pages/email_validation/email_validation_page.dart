import 'package:flutter/material.dart';
import 'package:perguntando/src/shared/widgets/scrollable_content/scrollable_content_widget.dart';

import '../../login_bloc.dart';
import '../../login_module.dart';

class EmailValidationPage extends StatefulWidget {
  @override
  _EmailValidationPageState createState() => _EmailValidationPageState();
}

class _EmailValidationPageState extends State<EmailValidationPage> {
  var loginBloc = LoginModule.to.bloc<LoginBloc>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: ScrollableContentWidget(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.2, bottom: 50),
            child: Text(
              "Verifique seu email",
              style: TextStyle(
                color: Colors.white,
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
            width: 250,
            height: 50,
            color: Colors.white,
          ),
          Container(
            padding: EdgeInsets.all(20),
            // alignment: Alignment.center,
            child: GestureDetector(
              onTap: () {
                loginBloc.pageController.animateToPage(
                  1,
                  duration: Duration(milliseconds: 1000),
                  curve: Curves.ease,
                );
              },
              child: Text(
                "Reenviar email",
                style: TextStyle(
                    decoration: TextDecoration.underline,
                    color: Color(0xffA7A7A7),
                    fontSize: 18,
                    fontWeight: FontWeight.w400),
              ),
            ),
          ),
        ],
        button: Container(
          padding: EdgeInsets.fromLTRB(20, 20, 20, 80),
          alignment: Alignment.bottomCenter,
          child: GestureDetector(
            onTap: () {
              loginBloc.pageController.animateToPage(
                1,
                duration: Duration(milliseconds: 1000),
                curve: Curves.ease,
              );
            },
            child: Text(
              "Voltar para o cadastro",
              style: TextStyle(
                  decoration: TextDecoration.underline,
                  color: Color(0xffA7A7A7),
                  fontSize: 18,
                  fontWeight: FontWeight.w400),
            ),
          ),
        ),
      ),
    );
  }
}
