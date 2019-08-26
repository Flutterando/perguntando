import 'dart:convert';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:perguntando/src/shared/models/notification_model.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotificationBloc extends BlocBase {
  var currentNotify = BehaviorSubject<List<String>>();

  Observable<int> get countNotify =>
      currentNotify.map((item) => item.length ?? 0);

  Observable<List<NotificationModel>> get notificationOut => currentNotify.stream.switchMap(observableNotify);    

  void addNotify(String data) {
    var list = currentNotify.value ?? <String>[];
    list.add(data);
    currentNotify.sink.add(list);
  }

  Stream<List<NotificationModel>> observableNotify(List<String> currentList) async* {
    try {
      var storage = await SharedPreferences.getInstance();
      List<String> list;
      if (storage.containsKey("notification")) {
        list = storage.getStringList("notification");
        yield list.map((item) => NotificationModel.fromJson(jsonDecode(item))).toList().reversed.toList();
      } else
        yield <NotificationModel>[];
    } catch (e) {
      print(e);
      throw e;
    }
  }

  void initNotify(){
    currentNotify.sink.add(null);
  }

  void closeNotify(){
    currentNotify.sink.add(null);
  }

  void deleteNotify(int index)async{
    if(index != null){
    var storage = await SharedPreferences.getInstance();
    var list = storage.getStringList("notification");
    list.reversed.toList();
    list.removeAt(index);
    await storage.setStringList("notification", list);
    }
    else
    initNotify();
  }

  @override
  void dispose() {
    currentNotify.close();
    super.dispose();
  }
}
