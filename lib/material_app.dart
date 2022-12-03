import 'package:flutter/material.dart';
import 'package:esomap_mobile/pages/home.material.dart';

class App extends StatelessWidget {
  const App({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Esomap Mobile',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
    );
  }
}

void runMaterialApp() {
  runApp(const App());
}
