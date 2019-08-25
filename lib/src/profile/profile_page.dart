import 'dart:async';
import 'dart:developer';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:perguntando/src/app_module.dart';
import 'package:perguntando/src/profile/profile_bloc.dart';
import 'package:perguntando/src/profile/profile_module.dart';
import 'package:perguntando/src/shared/blocs/auth_bloc.dart';
import 'package:perguntando/src/shared/models/user_model.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final _key = GlobalKey<FormState>();
  AuthBloc _authBloc = AppModule.to.getBloc<AuthBloc>();

  ProfileBloc _profileBloc = ProfileModule.to.getBloc<ProfileBloc>();
  StreamSubscription _subscription;

  @override
  void initState() {
    _subscription = _profileBloc.submit.listen(
      (e) => dialog(
          title: "Successo",
          content: "Suas informações foram atualizadas com sucesso."),
    );
    super.initState();
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }

  void dialog({String title, String content}) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(content),
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(
                    top: 15, left: 8, right: 8, bottom: 8),
                child: StreamBuilder(
                  stream: _authBloc.outUser,
                  initialData: _authBloc.userControleValue,
                  builder: (BuildContext context,
                      AsyncSnapshot<UserModel> snapshot) {
                    return CircleAvatar(
                      minRadius: 30,
                      maxRadius: 60,
                      backgroundImage: NetworkImage(snapshot.data?.photo ?? ''),
                    );
                  },
                ),
              ),
              Form(
                key: _key,
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 20, bottom: 8, left: 8, right: 8),
                      child: StreamBuilder(
                        stream: _authBloc.outUser,
                        initialData: _authBloc.userControleValue,
                        builder: (BuildContext context,
                            AsyncSnapshot<UserModel> snapshotUser) {
                          return StreamBuilder(
                            stream: _profileBloc.validName,
                            builder: (BuildContext context,
                                AsyncSnapshot<String> snapshot) {
                              return TextFormField(
                                onSaved: _profileBloc.nameEvent,
                                initialValue:
                                    "${snapshotUser.data?.name ?? ""}",
                                maxLines: 1,
                                style: TextStyle(
                                  color: Color(0xffA7A7A7),
                                ),
                                textAlign: TextAlign.center,
                                decoration: InputDecoration(
                                  errorText: snapshot.error,
                                  contentPadding: const EdgeInsets.only(
                                      top: 15, bottom: 10, left: 20),
                                  labelText: 'seu nome',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(50),
                                    borderSide: BorderSide(
                                        color: Colors.blueAccent, width: 2),
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      ),
                    ),
                    Divider(
                      color: Colors.grey[600],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: Text(
                        "Redefinir senha",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 15, bottom: 8, left: 8, right: 8),
                      child: StreamBuilder(
                        stream: _profileBloc.validPassword,
                        builder: (BuildContext context,
                            AsyncSnapshot<String> snapshot) {
                          return TextFormField(
                            onSaved: _profileBloc.passwordEvent,
                            maxLines: 1,
                            style: TextStyle(
                              color: Color(0xffA7A7A7),
                            ),
                            obscureText: true,
                            textAlign: TextAlign.center,
                            decoration: InputDecoration(
                              errorText: snapshot.error,
                              contentPadding: const EdgeInsets.only(
                                  top: 15, bottom: 10, left: 20),
                              labelText: 'sua senha',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(50),
                                borderSide: BorderSide(
                                    color: Colors.blueAccent, width: 2),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 15, bottom: 8, left: 8, right: 8),
                      child: StreamBuilder(
                        stream: _profileBloc.comparePassword,
                        builder:
                            (BuildContext context, AsyncSnapshot snapshot) {
                          return TextFormField(
                            onSaved: _profileBloc.rePasswordEvent,
                            maxLines: 1,
                            style: TextStyle(
                              color: Color(0xffA7A7A7),
                            ),
                            obscureText: true,
                            textAlign: TextAlign.center,
                            decoration: InputDecoration(
                              errorText: snapshot.error,
                              contentPadding: const EdgeInsets.only(
                                  top: 15, bottom: 10, left: 20),
                              labelText: 'repita sua senha',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(50),
                                borderSide: BorderSide(
                                    color: Colors.blueAccent, width: 2),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: 46,
                width: double.infinity,
                margin: const EdgeInsets.only(
                    left: 25, right: 25, top: 15, bottom: 20),
                child: RaisedButton(
                  shape: StadiumBorder(),
                  color: Colors.blue,
                  onPressed: () {
                    _key.currentState.save();
                  },
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 40),
                    child: Text(
                      "ATUALIZAR",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
