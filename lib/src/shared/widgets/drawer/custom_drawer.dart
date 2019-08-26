import 'package:flutter/material.dart';
import 'package:perguntando/src/app_module.dart';
import 'package:perguntando/src/login/login_module.dart';
import 'package:perguntando/src/shared/blocs/auth_bloc.dart';
import 'package:perguntando/src/splash/splash_page.dart';
import 'package:meta/meta.dart';

import '../../models/user_model.dart';

class DrawerWidget extends StatefulWidget {
  @override
  _DrawerWidgetState createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  final bloc = AppModule.to.bloc<AuthBloc>();

  Widget _listTile({String text = "",IconData icon = Icons.lightbulb_outline, bool selected = false, Function onTap}) {
    return Container(
      color: selected ? Colors.white : Colors.blue[800],
      child: ListTile(
        leading: Icon(
          icon,
          color: selected ? Colors.blue[800] : Colors.white,
          size: 35,
        ),
        title: Text(
          text.toUpperCase(),
          style: TextStyle(color: selected ? Colors.blue[800] : Colors.white),
        ),
        onTap: selected ? null : onTap,
      ),
    );
  }

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
                    _listTile(text: "Editar Conta", icon: Icons.person, onTap: (){}),
                    _listTile(text: "Eventos", icon: Icons.event_available, selected: true),
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
