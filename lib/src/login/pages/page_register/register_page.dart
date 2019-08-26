import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../login_bloc.dart';
import '../../login_module.dart';
import 'register_bloc.dart';


class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  var loginBloc = LoginModule.to.getBloc<LoginBloc>();
  var bloc = LoginModule.to.getBloc<RegisterBloc>();

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
              FlutterLogo(
                size: 130,
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: Container(
                      height: 2,
                      margin: EdgeInsets.only(right: 10),
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    "CADASTRO",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  Expanded(
                    child: Container(
                      height: 2,
                      margin: EdgeInsets.only(left: 10),
                      color: Colors.white,
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Form(
                child: Column(
                  children: <Widget>[
                    Container(
                      height: 50,
                      width: MediaQuery.of(context).size.width,
                      child: CupertinoTextField(
                        controller: bloc.nameController,
                        maxLines: 1,
                        style: TextStyle(
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
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      height: 50,
                      width: MediaQuery.of(context).size.width,
                      child: CupertinoTextField(
                        controller: bloc.mailController,
                        maxLines: 1,
                        style: TextStyle(
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
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 50,
                      child: CupertinoTextField(
                        controller: bloc.passwordController,
                        maxLines: 1,
                        style: TextStyle(
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
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 50,
                      child: CupertinoTextField(
                        controller: bloc.confirmPasswordController,
                        maxLines: 1,
                        style: TextStyle(
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
                    SizedBox(
                      height: 30,
                    ),
                    Container(
                      height: 46,
                      child: RaisedButton(
                        shape: StadiumBorder(),
                        color: Colors.blue,
                        onPressed: () {},
                        child: Padding(
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
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      padding: EdgeInsets.all(20),
                      child: GestureDetector(
                        onTap: () {
                          loginBloc.pageController.animateToPage(0,
                              duration: Duration(milliseconds: 1000),
                              curve: Curves.bounceOut);
                        },
                        child: Text(
                          "voltar para o login",
                          style: TextStyle(
                              decoration: TextDecoration.underline,
                              color: Color(0xffA7A7A7),
                              fontSize: 18,
                              fontWeight: FontWeight.w400),
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
