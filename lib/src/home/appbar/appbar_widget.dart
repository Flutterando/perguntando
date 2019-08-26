import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:perguntando/src/app_module.dart';
import 'package:perguntando/src/home/pages/notification/notification_page.dart';
import 'package:perguntando/src/shared/notification/notification_bloc.dart';
class AppbarWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          IconButton(
            icon: Icon(
              Icons.menu,
              color: Colors.white,
              size: 30,
            ),
            onPressed: Scaffold.of(context).openDrawer,
          ),
         IconButton(
            icon: Stack(
              children: <Widget>[
                Icon(
                  Icons.notifications,
                  size: 30,
                ),
                Positioned(
                  top: 1.0,
                  right: 0,
                  child: StreamBuilder<int>(
              stream: AppModule.to.getBloc<NotificationBloc>().countNotify,
              builder: (context,snapshot){
                  return snapshot.hasData ? CircleAvatar(
                    radius: 8,
                    child: Text("${snapshot.data}",style: TextStyle(color: Colors.white,fontSize: 13),),
                    backgroundColor: Colors.red,
                  ) : Container(width: 0.0,height: 0.0,);
              },
            ),
                ),
              ],
            ),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => NotificationPage()));
            },
          ),
         
        ],
      ),
    );
  }
}
