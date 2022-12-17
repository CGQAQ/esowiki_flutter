import 'package:esomap_mobile/pages/antiquity.mat.dart';
import 'package:esomap_mobile/pages/build.mat.dart';
import 'package:esomap_mobile/pages/build_detail.dart';
import 'package:esomap_mobile/pages/set.mat.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>();

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
            id: int.parse(state.params["id"] as String) ?? 0);
      }),
];

final _routes = GoRouter(initialLocation: "/set", routes: [
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
      body: SafeArea(child: widget.child),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
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
    );
  }
}

void runMaterialApp() {
  runApp(const App());
}
