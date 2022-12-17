import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../api/build.dart';

class BuildPage extends StatefulWidget {
  const BuildPage({Key? key}) : super(key: key);

  @override
  State<BuildPage> createState() => _BuildPageState();
}

class _BuildPageState extends State<BuildPage> {
  final _builds = <BuildsData>[];
  final _controller = ScrollController();

  @override
  void initState() {
    super.initState();

    _controller.addListener(scrollListener);

    refresh(reset: true);
  }

  @override
  dispose() {
    super.dispose();
    _controller.dispose();
  }

  void scrollListener() {
    if (_controller.position.pixels == _controller.position.maxScrollExtent) {
      refresh();
    }
  }

  refresh({bool reset = false}) async {
    final value = await getBuilds();

    setState(() {
      if (reset) {
        _builds.clear();
      }
      _builds.addAll(value.data);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        controller: _controller,
        itemCount: _builds.length,
        itemBuilder: (context, index) {
          final build = _builds[index];

          final title = build.attrs.title;
          final description = build.attrs.description;
          final image = build.attrs.image;

          return GestureDetector(
            onTap: () {
              context.go("/build/${build.id}");
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Material(
                elevation: 8,
                borderRadius: BorderRadius.circular(12),
                clipBehavior: Clip.antiAlias,
                type: MaterialType.card,
                child: SizedBox(
                  height: 100,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SizedBox(
                        width: 100,
                        height: 100,
                        child: FittedBox(
                          fit: BoxFit.fill,
                          child: Image.network(image),
                        ),
                      ),
                      Flexible(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8.0,
                            vertical: 0,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Text(
                                title,
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                description,
                                maxLines: 3,
                                style: const TextStyle(
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
