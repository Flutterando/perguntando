import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:perguntando/src/app_module.dart';
import 'package:perguntando/src/shared/models/notification_model.dart';
import 'package:perguntando/src/shared/notification/notification_bloc.dart';

class NotificationPage extends StatefulWidget {
  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  @override
  void initState() {
    AppModule.to.getBloc<NotificationBloc>().initNotify();
    super.initState();
  }

  @override
  void dispose() {
    AppModule.to.getBloc<NotificationBloc>().closeNotify();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon( Platform.isIOS ?   Icons.arrow_back_ios : Icons.arrow_back,color: Theme.of(context).primaryColor),
          onPressed: (){
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.white,
        title: Text("Notificações",style: TextStyle(color: Colors.grey,fontSize: 15),),
      ),
      body: StreamBuilder<List<NotificationModel>>(
          stream: AppModule.to.getBloc<NotificationBloc>().notificationOut,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(
                child:
                    Text("OPS!, não foi possível recuperar suas notificações"),
              );
            } else if (snapshot.hasData) {
              List<NotificationModel> list = snapshot.data;
              return ListView.builder(
                itemCount: list.length,
                itemBuilder: (context, index) => Dismissible(
                  key: Key(list[index].id),
                  background: Container(
                    color: Colors.red,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Icon(Icons.delete,color: Colors.white,),
                        Container(
                          width: 20.0,
                        )
                      ],
                    ),
                  ),
                  onDismissed: (direction){
                    if(direction == DismissDirection.endToStart){
                      Timer(Duration(milliseconds: 500), (){
                        AppModule.to.getBloc<NotificationBloc>().deleteNotify(index);
                      });
                     
                    }
                  },
                  child: Card(
                    elevation: 5.0,
                                      child: ListTile(
                      title: Text("${list[index].title}"),
                      leading: Icon(Icons.notifications,color: Theme.of(context).primaryColor),
                      subtitle: list[index].subtitle == null
                          ? Text("")
                          : Text("${list[index].subtitle}"),
                    ),
                  ),
                
                ),
              );
            } else {
              return Center(
                child: Text("Nenhuma notificação"),
              );
            }
          }),
    );
  }
}
