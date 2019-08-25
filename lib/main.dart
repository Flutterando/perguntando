import 'dart:io';

import 'package:flutter/material.dart';
import 'package:perguntando/src/app_module.dart';
import 'package:flutter/foundation.dart' show debugDefaultTargetPlatformOverride;
import 'dart:io' show Platform;

void main() {
  _setTargetPlatformForDesktop();
  runApp(AppModule());
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
