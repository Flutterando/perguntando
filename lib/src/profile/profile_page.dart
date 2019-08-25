import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:perguntando/src/app_module.dart';
import 'package:perguntando/src/shared/blocs/auth_bloc.dart';
import 'package:perguntando/src/shared/models/user_model.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}
/*
consegue trocar
nome,foto,senha
 
 consegue ver o email

*/

class _ProfilePageState extends State<ProfilePage> {
  AuthBloc _authBloc = AppModule.to.getBloc<AuthBloc>();

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
              Padding(
                padding: const EdgeInsets.only(
                    top: 20, bottom: 8, left: 8, right: 8),
                child: StreamBuilder(
                  stream: _authBloc.outUser,
                  initialData: _authBloc.userControleValue,
                  builder: (BuildContext context,
                      AsyncSnapshot<UserModel> snapshot) {
                    return TextFormField(
                      initialValue: "${snapshot.data?.name ?? ""}",
                      maxLines: 1,
                      style: TextStyle(
                        color: Color(0xffA7A7A7),
                      ),
                      textAlign: TextAlign.center,
                      obscureText: true,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.only(
                            top: 15, bottom: 10, left: 20),
                        labelText: 'seu nome',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50),
                          borderSide:
                              BorderSide(color: Colors.blueAccent, width: 2),
                        ),
                      ),
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
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    top: 15, bottom: 8, left: 8, right: 8),
                child: TextFormField(
                  maxLines: 1,
                  style: TextStyle(
                    color: Color(0xffA7A7A7),
                  ),
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    contentPadding:
                        const EdgeInsets.only(top: 15, bottom: 10, left: 20),
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
                  maxLines: 1,
                  style: TextStyle(
                    color: Color(0xffA7A7A7),
                  ),
                  obscureText: true,
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    contentPadding:
                        const EdgeInsets.only(top: 15, bottom: 10, left: 20),
                    labelText: 'repita sua senha',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50),
                      borderSide:
                          BorderSide(color: Colors.blueAccent, width: 2),
                    ),
                  ),
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
                  onPressed: () {},
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 40),
                    child: Text(
                      "CADASTRAR",
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
