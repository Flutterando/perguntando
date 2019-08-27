import 'dart:convert';

import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:perguntando/src/app_module.dart';
import 'package:perguntando/src/shared/models/notification_model.dart';
import 'package:perguntando/src/shared/notification/notification_bloc.dart';
import 'package:perguntando/src/shared/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotificationApp extends OneSignal {
  NotificationApp() {
    init(ONESIGNAL_API, iOSSettings: {
      OSiOSSettings.autoPrompt: false,
      OSiOSSettings.inAppLaunchUrl: true
    });

    OneSignal.shared
        .setInFocusDisplayType(OSNotificationDisplayType.notification);
    setNotificationReceivedHandler(handlerNotification);
  }

  void handlerNotification(OSNotification notification) async {
    var storage = await SharedPreferences.getInstance();
    List<String> list;
    var object = NotificationModel(
        title: notification.payload.title,
        subtitle: notification.payload.subtitle,
        id: notification.payload.notificationId,
        datetime: DateTime.now());

    var json = jsonEncode(object.toJson());
    
    AppModule.to.getBloc<NotificationBloc>().addNotify(json);

    if (storage.containsKey("notification")) {
      list = storage.getStringList("notification");
      list.add(json);
    } else {
      list = <String>[];
      list.add(json);
    }
    await storage.setStringList("notification", list);
  }
}
