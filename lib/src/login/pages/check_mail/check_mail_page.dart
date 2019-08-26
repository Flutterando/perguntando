import 'package:flutter/material.dart';
import 'package:pin_code_text_field/pin_code_text_field.dart';

import '../../login_bloc.dart';
import '../../login_module.dart';

class CheckMailPage extends StatefulWidget {
  @override
  _CheckMailPageState createState() => _CheckMailPageState();
}

class _CheckMailPageState extends State<CheckMailPage> {
  Size get size => MediaQuery.of(context).size;
  final loginBloc = LoginModule.to.bloc<LoginBloc>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Container(
          width: size.width,
          height: size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Spacer(),
              Text(
                'Verifique seu email',
                style: TextStyle(
                  fontSize: 30,
                  color: Color(0xffA7A7A7),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                width: size.width * 0.9,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Spacer(),
                    PinCodeTextField(
                      onDone: (v) {},
                      defaultBorderColor: Colors.blue,
                      highlightColor: Colors.blue,
                      hasTextBorderColor: Colors.blue,
                      pinCodeTextFieldLayoutType:
                          PinCodeTextFieldLayoutType.AUTO_ADJUST_WIDTH,
                      wrapAlignment: WrapAlignment.start,
                      pinBoxDecoration:
                          ProvidedPinBoxDecoration.defaultPinBoxDecoration,
                      pinTextStyle:
                          TextStyle(fontSize: 30.0, color: Color(0xffA7A7A7)),
                      pinTextAnimatedSwitcherTransition:
                          ProvidedPinBoxTextAnimation.scalingTransition,
                      pinTextAnimatedSwitcherDuration:
                          Duration(milliseconds: 300),
                      maskCharacter: '*',
                    ),
                    Spacer(),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'Reinviar codigo',
                style: TextStyle(
                    decoration: TextDecoration.underline,
                    color: Color(0xffA7A7A7),
                    fontSize: 18,
                    fontWeight: FontWeight.w400),
              ),
              Spacer(),
              InkWell(
                onTap: () {
                  loginBloc.pageController.animateToPage(1,
                      duration: Duration(milliseconds: 1000),
                      curve: Curves.bounceOut);
                },
                child: Text(
                  'Voltar para cadastro',
                  style: TextStyle(
                      decoration: TextDecoration.underline,
                      color: Color(0xffA7A7A7),
                      fontSize: 18,
                      fontWeight: FontWeight.w400),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
