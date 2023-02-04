import 'package:esomap_mobile/pages/antiquity.mat.dart';
import 'package:esomap_mobile/pages/build.mat.dart';
import 'package:esomap_mobile/pages/build_detail.dart';
import 'package:esomap_mobile/pages/home.dart';
import 'package:esomap_mobile/pages/set.mat.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class RouteMeta {
  final String name;
  final String path;
  final IconData? icon;
  final Widget Function(GoRouterState) widget;

  RouteMeta({
    required this.name,
    required this.path,
    this.icon,
    required this.widget,
  });
}

final _routesMeta = <RouteMeta>[
  RouteMeta(
    name: "主页",
    path: "/home",
    icon: Icons.home_rounded,
    widget: (_) => const HomePage(),
  ),
  RouteMeta(
    name: "套装",
    path: "/set",
    icon: Icons.interests_rounded,
    widget: (_) => const SetPage(),
  ),
  RouteMeta(
    name: "古物线索",
    path: "/antiquity",
    icon: Icons.local_attraction_rounded,
    widget: (_) => const AntiquityPage(),
  ),
  RouteMeta(
    name: "套路",
    path: "/builds",
    icon: Icons.account_tree_rounded,
    widget: (_) => const BuildPage(),
  ),
  RouteMeta(
      name: "套路 N",
      path: "/build/:id",
      widget: (state) {
        return BuildDetailPage(
            id: int.parse(state.params["id"] as String));
      }),
];

final _routes = GoRouter(initialLocation: "/home", routes: [
  ShellRoute(
      builder: (context, state, child) {
        return AppRoot(
          child: child,
        );
      },
      routes: <GoRoute>[
        ..._routesMeta.map(
          (meta) => GoRoute(
            path: meta.path,
            pageBuilder: (context, state) => CustomTransitionPage(
              child: meta.widget(state),
              transitionsBuilder: (context, _, __, child) {
                return FadeTransition(
                  opacity: const AlwaysStoppedAnimation(1),
                  child: child,
                );
              },
            ),
          ),
        )
      ]),
]);

class AppRoot extends StatefulWidget {
  final Widget child;

  const AppRoot({
    required this.child,
    Key? key,
  }) : super(key: key);

  @override
  State<AppRoot> createState() => _AppRootState();
}

class _AppRootState extends State<AppRoot> {
  var _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("ESO Wiki Mobile"),
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark,
        ),
      ),
      body: SafeArea(child: widget.child),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        backgroundColor: BottomNavigationBarTheme.of(context).backgroundColor,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
            context.go(_routesMeta[_currentIndex].path);
          });
        },
        items: [
          ..._routesMeta.where((element) => element.icon != null).map(
                (meta) => BottomNavigationBarItem(
                  icon: Icon(meta.icon),
                  label: meta.name,
                ),
              ),
        ],
      ),
    );
  }
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: "Eso Mobile",
      debugShowCheckedModeBanner: false,
      routerConfig: _routes,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: Colors.white,
          selectedItemColor: Colors.blue,
          unselectedItemColor: Colors.grey,
          showUnselectedLabels: true,
        ),
      )
    );
  }
}

void runMaterialApp() {
  runApp(const App());
}
