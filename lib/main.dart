import 'dart:io' show Platform;
import 'package:esomap_mobile/cupertino_app.dart';
import 'package:esomap_mobile/material_app.dart';
import 'package:flutter/foundation.dart';

void main() {
  if (kIsWeb) {
    throw UnsupportedError('Web is not supported, Please use esomap instead');
  }

  if (Platform.isAndroid ||
      Platform.isFuchsia ||
      Platform.isWindows ||
      Platform.isLinux) {
    runMaterialApp();
  } else if (Platform.isMacOS || Platform.isIOS) {
    runCupertinoApp();
  } else {
    throw UnsupportedError('Unsupported platform');
  }
}
