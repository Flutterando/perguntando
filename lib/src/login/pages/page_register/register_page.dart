import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:perguntando/src/app_module.dart';
import 'package:perguntando/src/login/pages/page_register/sign_up_bloc.dart';
import 'package:perguntando/src/shared/blocs/authentication_bloc.dart';
import 'package:perguntando/src/shared/models/user_model.dart';

import '../../login_bloc.dart';
import '../../login_module.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  final _splashBloc = LoginModule.to.getBloc<SplashBloc>();
  final _signUpBloc = LoginModule.to.getBloc<SignUpBloc>();
  final _authBloc = AppModule.to.bloc<AuthenticationBloc>();

  ReactionDisposer _requestReaction;

  @override
  void initState() {
    _requestReaction = reaction((_) => _signUpBloc.response.status, (_) {
      final response = _signUpBloc.response;
      if (response.status == FutureStatus.fulfilled) {
        _onSucess(response.value);
      } else if (response.status == FutureStatus.rejected) {
        _onError(response.error);
      }
    });
    super.initState();
  }

  void _onSucess(User user) {
    _authBloc.currentUser = user;
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Perfil atualizado com sucesso !"),
        actions: <Widget>[
          FlatButton(
            child: Text('Ok'),
            onPressed: () {
              Navigator.pop(context);
            },
          )
        ],
      ),
    );
  }

  void _onError(dynamic error) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Ocorreu um erro ao atualizar seu perfil"),
        actions: <Widget>[
          FlatButton(
            child: Text('Ok'),
            onPressed: () {
              Navigator.pop(context);
            },
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    _requestReaction();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
//        color: Colors.greenAccent,
        alignment: Alignment.center,
        padding: EdgeInsets.all(25),
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              const FlutterLogo(
                size: 130,
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: Container(
                      height: 2,
                      margin: const EdgeInsets.only(right: 10),
                      color: Colors.white,
                    ),
                  ),
                  const Text(
                    "CADASTRO",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  Expanded(
                    child: Container(
                      height: 2,
                      margin: const EdgeInsets.only(left: 10),
                      color: Colors.white,
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Form(
                child: Column(
                  children: <Widget>[
                    Container(
                      height: 50,
                      width: MediaQuery.of(context).size.width,
                      child: CupertinoTextField(
                        maxLines: 1,
                        style: const TextStyle(
                          color: Color(0xffA7A7A7),
                        ),
                        textAlign: TextAlign.center,
                        placeholder: 'seu nome',
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          border:
                              Border.all(color: Colors.blueAccent, width: 2),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      height: 50,
                      width: MediaQuery.of(context).size.width,
                      child: CupertinoTextField(
                        maxLines: 1,
                        style: const TextStyle(
                          color: Color(0xffA7A7A7),
                        ),
                        textAlign: TextAlign.center,
                        placeholder: 'seu email',
                        keyboardType: TextInputType.emailAddress,
                        autocorrect: false,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          border:
                              Border.all(color: Colors.blueAccent, width: 2),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 50,
                      child: CupertinoTextField(
                        maxLines: 1,
                        style: const TextStyle(
                          color: Color(0xffA7A7A7),
                        ),
                        textAlign: TextAlign.center,
                        obscureText: true,
                        placeholder: 'digita sua senha',
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          border:
                              Border.all(color: Colors.blueAccent, width: 2),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 50,
                      child: CupertinoTextField(
                        maxLines: 1,
                        style: const TextStyle(
                          color: Color(0xffA7A7A7),
                        ),
                        textAlign: TextAlign.center,
                        cursorRadius: Radius.circular(50),
                        placeholder: 'senha novamente',
                        obscureText: true,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          border:
                              Border.all(color: Colors.blueAccent, width: 2),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Container(
                      height: 46,
                      child: RaisedButton(
                        shape: const StadiumBorder(),
                        color: Colors.blue,
                        onPressed: () {
                          if (_formKey.currentState.validate()) {
                            _formKey.currentState.save();
                          }
                        },
                        child: const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 40),
                          child: Text(
                            "CADASTRAR",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      padding: const EdgeInsets.all(20),
                      child: GestureDetector(
                        onTap: () {
                          _splashBloc.pageController.animateToPage(0,
                              duration: const Duration(milliseconds: 1000),
                              curve: Curves.bounceOut);
                        },
                        child: const Padding(
                          padding: EdgeInsets.all(3),
                          child: Text(
                            "voltar para o login",
                            style: TextStyle(
                                decoration: TextDecoration.underline,
                                color: Color(0xffA7A7A7),
                                fontSize: 18,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
