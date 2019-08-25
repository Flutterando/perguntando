import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:perguntando/src/app_module.dart';
import 'package:flutter/foundation.dart' show debugDefaultTargetPlatformOverride;
import 'dart:io' show Platform;

void main() {
  
  runApp(AppModule());
  _setTargetPlatformForDesktop();
  _setOrientation();
  _initOneSignal();
  runApp(AppModule());
}

void _initOneSignal(){
  OneSignal.shared.init("0f25b644-56f3-4fa2-96bb-f5a72606ebb8");
  OneSignal.shared.setInFocusDisplayType(OSNotificationDisplayType.notification);
}

void _setOrientation(){
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
}

void _setTargetPlatformForDesktop() {
  TargetPlatform targetPlatform;

  if (Platform.isMacOS || Platform.isLinux || Platform.isWindows) {
    targetPlatform = TargetPlatform.fuchsia;
  }

  if (targetPlatform != null) {
    debugDefaultTargetPlatformOverride = targetPlatform;
  }
}
