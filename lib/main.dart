import 'dart:io' show Platform;
import 'package:esomap_mobile/cupertino_app.dart';
import 'package:esomap_mobile/material_app.dart';

void main() {
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
