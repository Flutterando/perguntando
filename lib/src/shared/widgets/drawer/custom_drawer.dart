import 'package:flutter/material.dart';
import 'package:perguntando/src/app_module.dart';
import 'package:perguntando/src/login/login_module.dart';
import 'package:perguntando/src/profile/profile_module.dart';
import 'package:perguntando/src/shared/blocs/auth_bloc.dart';
import 'package:perguntando/src/splash/splash_page.dart';

import '../../models/user_model.dart';

class DrawerWidget extends StatefulWidget {
  @override
  _DrawerWidgetState createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  final bloc = AppModule.to.bloc<AuthBloc>();
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return SizedBox.fromSize(
      size: Size(220, height),
      child: Drawer(
        child: Container(
          padding: EdgeInsets.zero,
          color: Colors.blue[800],
          child: Column(
            children: <Widget>[
              Container(
                height: 370,
                child: Column(
                  children: <Widget>[
                    StreamBuilder<UserModel>(
                        stream: bloc.outUser,
                        builder: (context, snapshot) {
                          return UserAccountsDrawerHeader(
                            decoration: BoxDecoration(
                              color: Colors.blue[800],
                            ),
                            accountName: Text(
                              snapshot.data != null && snapshot.hasData
                                  ? snapshot?.data?.name ?? ''
                                  : "Carregando...",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            accountEmail: Text(
                              snapshot.data != null && snapshot.hasData
                                  ? snapshot?.data?.email ?? ''
                                  : "Carregando...",
                            ),
                            currentAccountPicture: CircleAvatar(
                              minRadius: 10,
                              maxRadius: 15,
                              backgroundImage: NetworkImage(snapshot.hasData
                                  ? snapshot?.data?.photo
                                  : "https://media.istockphoto.com/vectors/man-avatar-icon-man-flat-icon-man-faceless-avatar-man-character-vector-id1027708446"),
                            ),
                          );
                        }),
                    ListTile(
                      leading: Icon(
                        Icons.person,
                        color: Colors.white,
                        size: 35,
                      ),
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ProfileModule()),
                      ),
                      title: Text(
                        "EDITAR CONTA",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    ListTile(
                      leading: Icon(
                        Icons.event_available,
                        color: Colors.white,
                        size: 35,
                      ),
                      title: Text(
                        "EVENTOS",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
              Spacer(),
              Container(
                height: 50,
                color: Colors.white,
                child: ListTile(
                  leading: Icon(
                    Icons.transit_enterexit,
                    color: Colors.black,
                    size: 35,
                  ),
                  title: Text(
                    "SAIR",
                    style: TextStyle(color: Colors.black),
                  ),
                  onTap: () async {
                    await AppModule.to.bloc<AuthBloc>().logOff();
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LoginModule(),
                        ));
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
