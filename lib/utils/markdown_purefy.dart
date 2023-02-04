import 'package:html2md/html2md.dart' as html2md;

String markpure(String input) {
  // final regExp = RegExp(r".*<(\w+).*?>(.*?)</.*?>.*", multiLine: true, caseSensitive: false);
  // images
  final regExpImg = RegExp(r'.*<img.*?src="(.*?)".*?>.*', multiLine: true, caseSensitive: false);
  // videos
  final regExpVideo = RegExp(r'.*<video.*?src="(.*?)".*?>.*', multiLine: true, caseSensitive: false);


  String newStr = input;
  newStr = newStr.replaceAllMapped(regExpImg, (matched) {
    return html2md.convert(matched.group(0) ?? "");
  });

  newStr = newStr.replaceAllMapped(regExpVideo, (matched) {
    return html2md.convert(matched.group(0) ?? "");
  });

  return newStr;
}
