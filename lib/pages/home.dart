import 'package:esomap_mobile/api/articles.dart';
import 'package:esomap_mobile/utils/markdown_purefy.dart';
import 'package:flutter/material.dart';
import 'package:markdown_widget/markdown_widget.dart';
import 'package:url_launcher/url_launcher.dart';

class Meta {
  final String name;
  final String content;

  const Meta({required this.name, required this.content});
}

const List<Meta> metas = [
  Meta(name: "名称", content: "上古卷轴OL"),
  Meta(name: "英文", content: "The Elder Scrolls Online"),
  Meta(name: "发行日期", content: "2014 年 4 月 4 日"),
  Meta(name: "游戏类型", content: "MMORPG"),
  Meta(name: "评价", content: "特别好评"),
  Meta(name: "开发商", content: "Zenimax Online Studios"),
  Meta(name: "发行商", content: "Bethesda Softworks"),
  Meta(name: "引擎", content: "The Elder Scrolls Online"),
  Meta(name: "平台", content: "PC、Xbox One、PlayStation 4"),
  Meta(name: "语言", content: "英语、中文"),
  Meta(name: "官方网站", content: "https://www.elderscrollsonline.com/"),
  Meta(name: "官方论坛", content: "https://forums.elderscrollsonline.com/"),
  Meta(name: "官方微博", content: "https://weibo.com/elderscrollsonline"),
];

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        const Expanded(flex: 0, child: const MetaInfo()),
        Expanded(
          child: FutureBuilder<ArticlesAttributes>(
              future: getArticleById("1"),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: MarkdownWidget(
                      data: markpure(snapshot.data?.content ?? ""),
                      config: MarkdownConfig(configs: [
                        LinkConfig(
                          onTap: (url) {
                            print(url);
                          },
                        ),
                      ]),
                    ),
                  );
                } else if (snapshot.hasError) {
                  print(snapshot.error);
                  return const Text("error");
                } else {
                  return const Placeholder();
                }
              }),
        ),
      ],
    );
  }
}

class MetaInfo extends StatelessWidget {
  const MetaInfo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.lightbulb_outline,
                size: 24,
              ),
              const Text(
                "游戏信息",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const Divider(),
          ...metas
              .map((e) => Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Text(
                        e.name,
                        style: const TextStyle(fontSize: 18),
                      ),
                      const Text(": "),
                      Flexible(
                        fit: FlexFit.tight,
                        child: e.content.startsWith("https://")
                            ? InkWell(
                                onTap: () {
                                  try {
                                    launchUrl(Uri.parse(e.content), mode: LaunchMode.externalApplication);
                                  } catch (e) {
                                    print(e);
                                  }
                                },
                                child: Text(
                                  e.content,
                                  style: const TextStyle(
                                      fontSize: 18,
                                      decoration: TextDecoration.underline,
                                      color: Colors.blue),
                                  maxLines: 1,
                                  overflow: TextOverflow.fade,
                                  softWrap: false,
                                ),
                              )
                            : Text(
                                e.content,
                                style: const TextStyle(
                                  fontSize: 18,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.fade,
                                softWrap: false,
                              ),
                      ),
                    ],
                  ))
              .toList(),
          const Divider(),
        ],
      ),
    );
  }
}
