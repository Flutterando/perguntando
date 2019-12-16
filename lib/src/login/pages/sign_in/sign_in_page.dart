import 'dart:core' as prefix0;
import 'dart:core';

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';
import 'package:perguntando/src/app_module.dart';
import 'package:perguntando/src/home/home_module.dart';
import 'package:perguntando/src/shared/blocs/authentication_bloc.dart';
import 'package:perguntando/src/shared/models/user_model.dart';
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
  final _signInBloc = LoginModule.to.getBloc<SignInBloc>();
  final _loginBloc = LoginModule.to.bloc<SplashBloc>();
  final _authBloc = AppModule.to.bloc<AuthenticationBloc>();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    reaction((_) => _signInBloc.response.status, (_) {
      final response = _signInBloc.response;
      if (response.status == FutureStatus.fulfilled) {
        _onSuccess(response.value);
      } else if (response.status == FutureStatus.rejected) {
        _onError(response.error);
      }
    });
  }

  void _onSuccess(User user) {
    _authBloc.currentUser = user;
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => HomeModule(),
      ),
    );
  }

  void _onError(dynamic error) {
    showDialog(
        context: context,
        builder: (_) => AlertDialog(
              title: const Text("Ocorreu um erro"),
              actions: <Widget>[
                RaisedButton(
                  child:const Text("Terminei"),
                  onPressed: () {},
                )
              ],
            ));
  }

  OutlineInputBorder outlineborder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(30),
      borderSide: const BorderSide(color: Colors.blue, width: 2),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.only(top: 25, left: 25, right: 25),
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 100,
                width: 100,
                child: Image.asset("assets/logo.png"),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                width: 0,
                constraints: BoxConstraints(
                  minWidth: 230,
                ),
                child: Column(
                  children: <Widget>[
                    const FittedBox(
                      child: Text(
                        "Perguntando",
                        style: TextStyle(color: Colors.white, fontSize: 30),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        const Text(
                          "by Flutterando",
                          style: TextStyle(color: Colors.white, fontSize: 14),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    width: 100,
                    height: 2,
                    margin: const EdgeInsets.only(right: 10),
                    color: Colors.white,
                  ),
                  const Text(
                    "LOGIN",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  Container(
                    width: 100,
                    height: 2,
                    margin: const EdgeInsets.only(left: 10),
                    color: Colors.white,
                  )
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              Form(
                key: _formKey,
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
                          _signInBloc.email = v;
                        },
                        maxLines: 1,
                        style: const TextStyle(
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
                          hintStyle: const TextStyle(
                            color: Color(0xffA7A7A7),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
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
                          _signInBloc.password = v;
                        },
                        maxLines: 1,
                        style: const TextStyle(
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
                          hintStyle: const TextStyle(
                            color: Color(0xffA7A7A7),
                          ),
                        ),
                        obscureText: true,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(top: 20),
                      width: double.infinity,
                      child: GestureDetector(
                        onTap: () {},
                        child: const Text(
                          "esqueci minha senha",
                          textAlign: TextAlign.end,
                          style: TextStyle(
                              color: Color(0xffA7A7A7),
                              fontSize: 16,
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                    ),
                    Observer(
                      builder: (_) {
                        final error = _signInBloc.response.status ==
                            FutureStatus.rejected;

                        if (error is Error) {
                          return const SizedBox(
                            height: 50,
                            child: Center(
                              child: Text(
                                'Erro na autenticação',
                                style: TextStyle(color: Colors.red),
                              ),
                            ),
                          );
                        }
                        return const SizedBox(
                          height: 30,
                        );
                      },
                    ),
                    Container(
                      height: 46,
                      child: Observer(builder: (_) {
                        final loading =
                            _signInBloc.response.status == FutureStatus.pending;
                        return AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          curve: Curves.easeInOut,
                          decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(40)),
                          height: 30,
                          width: loading ? 48 : 150,
                          alignment: Alignment.center,
                          child: InkWell(
                            onTap: () {
                              if (_formKey.currentState.validate()) {
                                _formKey.currentState.save();
                                _signInBloc.submit();
                              }
                            },
                            child: !loading
                                ? const Text(
                                    "ENTRAR",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  )
                                : const Padding(
                                    padding: EdgeInsets.all(10),
                                    child: CircularProgressIndicator(
                                        backgroundColor: Colors.white)),
                          ),
                        );
                      }),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Container(
                      padding: const EdgeInsets.all(20),
                      child: GestureDetector(
                        onTap: () {
                          _loginBloc.pageController.animateToPage(1,
                              duration: const Duration(milliseconds: 1000),
                              curve: Curves.bounceOut);
                        },
                        child: const Padding(
                          padding: const EdgeInsets.all(3),
                          child: Text(
                            "cadastre-se agora",
                            style: const TextStyle(
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
              const SizedBox(
                height: 25,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
