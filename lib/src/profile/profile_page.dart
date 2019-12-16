import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';
import 'package:perguntando/src/app_module.dart';
import 'package:perguntando/src/profile/profile_bloc.dart';
import 'package:perguntando/src/profile/profile_module.dart';
import 'package:perguntando/src/shared/blocs/authentication_bloc.dart';
import 'package:perguntando/src/shared/models/user_model.dart';

class ProfilePage extends StatefulWidget {
  
  const ProfilePage({Key key}) : super(key: key);
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final _key = GlobalKey<FormState>();
  final _authBloc = AppModule.to.getBloc<AuthenticationBloc>();
  final _profileBloc = ProfileModule.to.getBloc<ProfileBloc>();
  ReactionDisposer _requestReaction;

  @override
  void initState() {
    _requestReaction = reaction((_) => _profileBloc.response.status, (_) {
      final response = _profileBloc.response;
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
        title: const Text("Perfil atualizado com sucesso !"),
        actions: <Widget>[
          FlatButton(
            child:const Text('Ok'),
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
        title:const Text("Ocorreu um erro ao atualizar seu perfil"),
        actions: <Widget>[
          FlatButton(
            child:const Text('Ok'),
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
      appBar: AppBar(
        title:const Text("Profile"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(
                    top: 15, left: 8, right: 8, bottom: 8),
                child: Observer(
                  builder: (_) {
                    final user = _authBloc.currentUser;
                    return CircleAvatar(
                      minRadius: 30,
                      maxRadius: 60,
                      backgroundImage: NetworkImage(user.photo ?? ''),
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
                      child: Observer(
                        builder: (_) {
                          final user = _authBloc.currentUser;
                          return TextFormField(
                            onSaved: (e) => _profileBloc.name = e,
                            initialValue: user.name,
                            maxLines: 1,
                            style: const TextStyle(
                              color: Color(0xffA7A7A7),
                            ),
                            textAlign: TextAlign.center,
                            decoration: InputDecoration(
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
                      ),
                    ),
                    Divider(
                      color: Colors.grey[600],
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 8),
                      child: Text(
                        "Redefinir senha",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 15, bottom: 8, left: 8, right: 8),
                      child: TextFormField(
                        onSaved: (e) => _profileBloc.password = e,
                        maxLines: 1,
                        style: const TextStyle(
                          color: Color(0xffA7A7A7),
                        ),
                        obscureText: true,
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.only(
                              top: 15, bottom: 10, left: 20),
                          labelText: 'sua senha',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50),
                            borderSide:
                                BorderSide(color: Colors.blueAccent, width: 2),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 15, bottom: 8, left: 8, right: 8),
                      child: TextFormField(
                        onSaved: (e) => _profileBloc.repeatPassword = e,
                        maxLines: 1,
                        style:const TextStyle(
                          color: Color(0xffA7A7A7),
                        ),
                        obscureText: true,
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.only(
                              top: 15, bottom: 10, left: 20),
                          labelText: 'repita sua senha',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50),
                            borderSide:
                                BorderSide(color: Colors.blueAccent, width: 2),
                          ),
                        ),
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
                  shape:const StadiumBorder(),
                  color: Colors.blue,
                  onPressed: () {
                    _key.currentState.save();
                  },
                  child:const Padding(
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
