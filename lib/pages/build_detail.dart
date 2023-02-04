import 'package:esomap_mobile/api/build.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:markdown_widget/markdown_widget.dart';

class BuildDetailPage extends StatelessWidget {
  final int id;

  const BuildDetailPage({Key? key, required this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: FutureBuilder(
          future: getBuilds(id: id),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final build = snapshot.data as BuildsResponse;
              final content = build.data[0].attrs.content;

              return Scaffold(
                appBar: AppBar(
                  title: Text(build.data[0].attrs.title),
                  leading: IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () => context.pushReplacement("/builds"),
                  ),
                ),
                body: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Expanded(child: MarkdownWidget(data: content)),
                ),
              );
            }
            return const Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}
