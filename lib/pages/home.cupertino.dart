import 'package:flutter/cupertino.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('EsoMap Mobile'),
      ),
      child: Center(
        child: Text('Hello World'),
      ),
    );
  }
}
