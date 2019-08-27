import 'dart:core' as prefix0;
import 'dart:core';

import 'package:flutter/material.dart';
import 'package:perguntando/src/app_module.dart';
import 'package:perguntando/src/home/home_module.dart';
import 'package:perguntando/src/login/pages/sign_up/sign_up_bloc.dart';
import 'package:perguntando/src/shared/blocs/auth_bloc.dart';
import 'package:perguntando/src/shared/models/user_state.dart';

import 'package:validators/validators.dart' as validators;

import '../../login_bloc.dart';
import '../../login_module.dart';
import 'sign_in_bloc.dart';

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  var signInBloc = LoginModule.to.getBloc<SignInBloc>();
  var signUpBloc = LoginModule.to.getBloc<SignUpBloc>();
  final loginBloc = LoginModule.to.bloc<LoginBloc>();
  final authBloc = AppModule.to.bloc<AuthBloc>();
  final _keyButton = GlobalKey();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    authBloc.outUser.listen((v) {
      if (v != null)
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => HomeModule(),
          ),
        );
    });
    authBloc.inUserState.add(NotAuthenticated());
  }

  OutlineInputBorder outlineborder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(30),
      borderSide: BorderSide(color: Colors.blue, width: 2),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.only(top: 25, left: 25, right: 25),
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              SizedBox(height: 20),
              SizedBox(
                height: 100,
                width: 100,
                child: Image.asset("assets/logo.png"),
              ),
              SizedBox(height: 20),
              Container(
                width: 0,
                constraints: BoxConstraints(
                  minWidth: 230,
                ),
                child: Column(
                  children: <Widget>[
                    FittedBox(
                      child: Text(
                        "Perguntando",
                        style: TextStyle(color: Colors.white, fontSize: 30),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Text(
                          "by Flutterando",
                          style: TextStyle(color: Colors.white, fontSize: 14),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    width: 100,
                    height: 2,
                    margin: EdgeInsets.only(right: 10),
                    color: Colors.white,
                  ),
                  Text(
                    "LOGIN",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  Container(
                    width: 100,
                    height: 2,
                    margin: EdgeInsets.only(left: 10),
                    color: Colors.white,
                  )
                ],
              ),
              SizedBox(height: 30),
              Form(
                key: signInBloc.formKey,
                child: Column(
                  children: <Widget>[
                    Container(
                      width: MediaQuery.of(context).size.width,
                      child: TextFormField(
                        validator: (v) {
                          if (v.isEmpty) {
                            return 'O campo não pode ser vazio';
                          } else if (!validators.isEmail(v)) {
                            return 'O email não é válido';
                          }
                          return null;
                        },
                        onSaved: (v) {
                          signInBloc.email = v;
                        },
                        maxLines: 1,
                        style: TextStyle(
                          color: Color(0xffA7A7A7),
                        ),
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                          alignLabelWithHint: true,
                          focusedBorder: outlineborder(),
                          border: outlineborder(),
                          enabledBorder: outlineborder(),
                          disabledBorder: outlineborder(),
                          hasFloatingPlaceholder: false,
                          hintText: "email",
                          hintStyle: TextStyle(
                            color: Color(0xffA7A7A7),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      child: TextFormField(
                        validator: (v) {
                          if (v.isEmpty) {
                            return 'O campo não pode ser vazio';
                          } else if (v.length < 4) {
                            return 'Senha muito curta';
                          }
                          return null;
                        },
                        onSaved: (v) {
                          signInBloc.password = v;
                        },
                        maxLines: 1,
                        style: TextStyle(
                          color: Color(0xffA7A7A7),
                        ),
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                          focusedBorder: outlineborder(),
                          border: outlineborder(),
                          enabledBorder: outlineborder(),
                          disabledBorder: outlineborder(),
                          hasFloatingPlaceholder: false,
                          hintText: "password",
                          hintStyle: TextStyle(
                            color: Color(0xffA7A7A7),
                          ),
                        ),
                        obscureText: true,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 20),
                      width: double.infinity,
                      child: GestureDetector(
                        onTap: () {},
                        child: Text(
                          "esqueci minha senha",
                          textAlign: TextAlign.end,
                          style: TextStyle(
                            color: Color(0xffA7A7A7),
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ),
                    StreamBuilder<AuthState>(
                        stream: authBloc.outUserState,
                        builder: (context, snapshot) {
                          if (snapshot.data is Error) {
                            return SizedBox(
                              height: 50,
                              child: Center(
                                child: Text(
                                  'Erro na autenticação',
                                  style: TextStyle(color: Colors.red),
                                ),
                              ),
                            );
                          }
                          return SizedBox(height: 50);
                        }),
                    Container(
                      height: 46,
                      child: StreamBuilder<AuthState>(
                        stream: authBloc.outUserState,
                        initialData: NotAuthenticated(),
                        builder: (context, snapshot) {
                          if (snapshot.data is Loading) {
                            return _buttonEnter(true);
                          }
                          return _buttonEnter(false);
                        },
                      ),
                    ),
                    SizedBox(height: 15),
                    Container(
                      padding: EdgeInsets.all(20),
                      child: GestureDetector(
                        onTap: () {
                          loginBloc.pageController.animateToPage(
                            1,
                            duration: Duration(milliseconds: 1000),
                            curve: Curves.ease,
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(3),
                          child: Text(
                            "cadastre-se agora",
                            style: TextStyle(
                                decoration: TextDecoration.underline,
                                color: Color(0xffA7A7A7),
                                fontSize: 18,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 25),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buttonEnter(bool isLoading) {
    return AnimatedContainer(
      key: _keyButton,
      duration: Duration(milliseconds: 200),
      curve: Curves.easeInOut,
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        borderRadius: BorderRadius.circular(40),
      ),
      height: 30,
      width: isLoading ? 48 : 150,
      alignment: Alignment.center,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: () {
            FocusScope.of(context).requestFocus(FocusNode());
            signInBloc.onLogin();
          },
          child: !isLoading
              ? Container(
                  width: 150,
                  height: 50,
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(40)),
                  child: Center(
                    child: Text(
                      "ENTRAR",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                )
              : Padding(
                  padding: EdgeInsets.all(10),
                  child:
                      CircularProgressIndicator(backgroundColor: Colors.white)),
        ),
      ),
    );
  }
}
