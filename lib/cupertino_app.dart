import 'package:flutter/cupertino.dart';
import 'package:esomap_mobile/pages/set.cup.dart';

class App extends StatelessWidget {
  const App({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const CupertinoApp(
      title: 'EsoMap Mobile',
      theme: CupertinoThemeData(
        primaryColor: CupertinoColors.activeBlue,
      ),
      home: HomePage(),
    );
  }
}

void runCupertinoApp() {
  runApp(const App());
}
