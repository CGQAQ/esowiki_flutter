import 'package:esomap_mobile/api/antiquity.dart';
import 'package:flutter/material.dart';

class AntiquityPage extends StatefulWidget {
  const AntiquityPage({super.key});

  @override
  State<AntiquityPage> createState() => _AntiquityPageState();
}

class _AntiquityPageState extends State<AntiquityPage> {
  final controller = ScrollController();
  final searchController = TextEditingController();

  var antiquities = <AntiquitiesData>[];

  var currentPage = 0;

  var pageSize = 0;

  var stillHaveData = true;

  var keyword = "";

  var isSearching = false;

  @override
  void initState() {
    super.initState();
    antiquities = [];

    refresh(reset: true);
    controller.addListener(scrollListener);
  }

  Future<void> refresh({bool reset = false}) async {
    final value = await getAntiquities(
      pageCurrent: currentPage,
      keyword: keyword,
    );

    setState(() {
      if (reset) {
        antiquities = value.data;
      } else {
        antiquities.addAll(value.data);
      }
      pageSize = value.meta.pagination.pageSize;
      stillHaveData = value.meta.pagination.pageCount - 1 > currentPage;
    });
  }

  void scrollListener() {
    if (controller.position.pixels == controller.position.maxScrollExtent) {
      if (stillHaveData) {
        refresh();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        print(index);

        if (index == antiquities.length) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        final item = antiquities[index].attributes;

        return ListTile(
          title: Text(item.name),
          leading: Image.network(item.setIcon == null || item.setIcon.isEmpty ? item.icon : item.setIcon),
        );
      },
      itemCount: antiquities.length,
    );
  }
}
