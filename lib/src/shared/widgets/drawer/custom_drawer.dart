import 'package:flutter/material.dart';
import 'package:perguntando/src/app_module.dart';
import 'package:perguntando/src/login/login_module.dart';
import 'package:perguntando/src/profile/profile_module.dart';
import 'package:perguntando/src/shared/blocs/authentication_bloc.dart';
import 'package:perguntando/src/shared/widgets/drawer/custom_list_tile.dart';

class DrawerWidget extends StatefulWidget {
  @override
  _DrawerWidgetState createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  final bloc = AppModule.to.bloc<AuthenticationBloc>();

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final user = bloc.currentUser;
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
                    UserAccountsDrawerHeader(
                      decoration: BoxDecoration(
                        color: Colors.blue[800],
                      ),
                      accountName: Text(
                        user.name,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      accountEmail: Text(
                        user.email,
                      ),
                      currentAccountPicture: CircleAvatar(
                        minRadius: 10,
                        maxRadius: 15,
                        backgroundImage: NetworkImage(user.photo ??
                            "https://media.istockphoto.com/vectors/man-avatar-icon-man-flat-icon-man-faceless-avatar-man-character-vector-id1027708446"),
                      ),
                    ),
                    CustomListTile(
                      text: "Editar Conta",
                      icon: Icons.person,
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ProfileModule()));
                      },
                    ),
                    CustomListTile(
                        text: "Eventos",
                        icon: Icons.event_available,
                        selected: true),
                  ],
                ),
              ),
              const Spacer(),
              Container(
                height: 50,
                color: Colors.white,
                child: ListTile(
                  leading: const Icon(
                    Icons.transit_enterexit,
                    color: Colors.black,
                    size: 35,
                  ),
                  title: const Text(
                    "SAIR",
                    style: TextStyle(color: Colors.black),
                  ),
                  onTap: () async {
                    AppModule.to.bloc<AuthenticationBloc>().signOut();

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
