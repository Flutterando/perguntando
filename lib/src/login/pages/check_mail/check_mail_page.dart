import 'package:flutter/material.dart';
import 'package:perguntando/src/login/pages/sign_up/sign_up_bloc.dart';
import 'package:pin_code_text_field/pin_code_text_field.dart';

import '../../login_bloc.dart';
import '../../login_module.dart';
import 'check_mail_bloc.dart';

class CheckMailPage extends StatefulWidget {
  @override
  _CheckMailPageState createState() => _CheckMailPageState();
}

class _CheckMailPageState extends State<CheckMailPage> {
  Size get size => MediaQuery.of(context).size;
  final loginBloc = LoginModule.to.bloc<LoginBloc>();
  final singUpBloc = LoginModule.to.bloc<SignUpBloc>();
  final checkMailBloc = LoginModule.to.bloc<CheckMailBloc>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Material(
        color: Colors.transparent,
        child: Container(
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
                    StreamBuilder<String>(
                        stream: checkMailBloc.outError,
                        builder: (context, snapshot) {
                          return PinCodeTextField(
                            onDone: (v) async {
                              final code =
                                  singUpBloc.userRegister.code.toString();
                              if (v == code) {
                                final check =
                                    await checkMailBloc.onRegisterUser();
                                if (check) {
                                  loginBloc.scaffoldKeySingInPage.currentState
                                      .showSnackBar(
                                    SnackBar(
                                      content: Text(
                                          'Registro realizado com sucesso!'),
                                    ),
                                  );
                                } else {
                                  loginBloc.scaffoldKeySingInPage.currentState
                                      .showSnackBar(
                                    SnackBar(
                                      content: Text('Erro ao registrar!'),
                                    ),
                                  );
                                }
                                loginBloc.pageController.animateToPage(
                                  0,
                                  duration: Duration(milliseconds: 1000),
                                  curve: Curves.ease,
                                );
                              }
                            },
                            hasError: snapshot.hasError,
                            defaultBorderColor: Colors.blue,
                            highlightColor: Colors.blue,
                            hasTextBorderColor: Colors.blue,
                            pinCodeTextFieldLayoutType:
                                PinCodeTextFieldLayoutType.AUTO_ADJUST_WIDTH,
                            wrapAlignment: WrapAlignment.start,
                            pinBoxDecoration: ProvidedPinBoxDecoration
                                .defaultPinBoxDecoration,
                            pinTextStyle: TextStyle(
                                fontSize: 30.0, color: Color(0xffA7A7A7)),
                            pinTextAnimatedSwitcherTransition:
                                ProvidedPinBoxTextAnimation.scalingTransition,
                            pinTextAnimatedSwitcherDuration:
                                Duration(milliseconds: 300),
                            maskCharacter: '*',
                          );
                        }),
                    Spacer(),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              StreamBuilder(
                builder: (context, snapshot) => snapshot.hasError
                    ? Text(snapshot.error.toString())
                    : SizedBox(),
              ),
              InkWell(
                onTap: () async {
                  // reinviar o codigo
                  Scaffold.of(context).showSnackBar(
                    SnackBar(
                      content:
                          Text('Codigo Reinviado para ${singUpBloc.email}'),
                    ),
                  );
                  await singUpBloc.onSingUp();
                },
                child: Text(
                  'Reinviar codigo',
                  style: TextStyle(
                      decoration: TextDecoration.underline,
                      color: Color(0xffA7A7A7),
                      fontSize: 18,
                      fontWeight: FontWeight.w400),
                ),
              ),
              Spacer(),
              InkWell(
                onTap: () {
                  loginBloc.pageController.animateToPage(1,
                      duration: Duration(milliseconds: 1000),
                      curve: Curves.ease);
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
