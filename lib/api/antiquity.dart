import 'dart:convert';

import "package:http/http.dart" as http;
import 'package:json_annotation/json_annotation.dart';

part "antiquity.g.dart";

Future<AntiquitiesResponse> getAntiquities({
  int pageCurrent = 0,
  int pageSize = 20,
  String keyword = "",
}) async {
  String url =
      "https://esoapi.denohub.com/api/antiquity-leads?pagination[page]=$pageCurrent&pagination[pageSize]=$pageSize&filters[name][\$containsi]=$keyword";

  final resp =
      await http.get(Uri.parse(url)).then((value) => jsonDecode(value.body));
  final antiquities = AntiquitiesResponse.fromJson(resp);

  for (final antiquity in antiquities.data) {
    String normalizedUrl(str) {
      if (str.startsWith("//")) {
        return "https:$str";
      } else {
        return str;
      }
    }

    antiquity.attributes.categoryIcon =
        normalizedUrl(antiquity.attributes.categoryIcon);
    antiquity.attributes.icon = normalizedUrl(antiquity.attributes.icon);
    antiquity.attributes.setIcon = normalizedUrl(antiquity.attributes.setIcon);
  }

  return antiquities;
}

@JsonSerializable()
class AntiquitiesMetaPagination {
  int page;
  int pageSize;
  int pageCount;
  int total;

  AntiquitiesMetaPagination(
      {required this.page,
      required this.pageSize,
      required this.pageCount,
      required this.total});

  factory AntiquitiesMetaPagination.fromJson(Map<String, dynamic> json) =>
      _$AntiquitiesMetaPaginationFromJson(json);

  Map<String, dynamic> toJson() => _$AntiquitiesMetaPaginationToJson(this);
}

@JsonSerializable()
class AntiquitiesMeta {
  AntiquitiesMetaPagination pagination;

  AntiquitiesMeta({required this.pagination});

  factory AntiquitiesMeta.fromJson(Map<String, dynamic> json) =>
      _$AntiquitiesMetaFromJson(json);

  Map<String, dynamic> toJson() => _$AntiquitiesMetaToJson(this);
}

@JsonSerializable()
class AntiquitiesDataAttr {
  // "name": "先祖兽人：斧头",
  String name;
  // "icon": "//esoicons.uesp.net/esoui/art/icons/quest_letter_002.png",
  String icon;
  // "quality": 2,
  int quality;
  // "difficulty": 1,
  int difficulty;
  // "requiresLead": 1,
  int requiresLead;
  // "rewardId": 2041,
  int rewardId;
  // "zoneId": 534,
  int zoneId;
  // "setId": 0,
  int setId;
  // "setName": "",
  String setName;
  // "setIcon": "",
  String setIcon;
  // "setQuality": -1,
  int setQuality;
  // "setRewardId": -1,
  int setRewardId;
  // "setCount": -1,
  int setCount;
  // "categoryId": 7,
  int categoryId;
  // "categoryName": "斯特罗斯·迈凯",
  String categoryName;
  // "categoryIcon": "//esoicons.uesp.net/esoui/art/icons/icon_missing.png",
  String categoryIcon;
  // "categoryOrder": 0,
  int categoryOrder;
  // "categoryCount": 9,
  int categoryCount;
  // "loreName1": "乌隆·格罗·图莫格",
  String loreName1;
  // "loreDescription1": "眼看时间就要瓦解掉这本书，我却惊讶于其清晰的内容。我们一定要小心处理，如果不做好防范措施，封皮可能维持不了多久。",
  String loreDescription1;
  // "loreName2": "",
  String loreName2;
  // "loreDescription2": "",
  String loreDescription2;
  // "loreName3": "",
  String loreName3;
  // "loreDescription3": "",
  String loreDescription3;
  // "loreName4": "",
  String loreName4;
  // "loreDescription4": "",
  String loreDescription4;
  // "loreName5": "",
  String loreName5;
  // "loreDescription5": "",
  String loreDescription5;
  // "createdAt": "2022-12-05T07:35:47.006Z",
  String createdAt;
  // "updatedAt": "2022-12-05T07:35:47.006Z",
  String updatedAt;
  // "publishedAt": "2022-12-05T07:35:47.005Z"
  String publishedAt;

  AntiquitiesDataAttr(
      {required this.name,
      required this.icon,
      required this.quality,
      required this.difficulty,
      required this.requiresLead,
      required this.rewardId,
      required this.zoneId,
      required this.setId,
      required this.setName,
      required this.setIcon,
      required this.setQuality,
      required this.setRewardId,
      required this.setCount,
      required this.categoryId,
      required this.categoryName,
      required this.categoryIcon,
      required this.categoryOrder,
      required this.categoryCount,
      required this.loreName1,
      required this.loreDescription1,
      required this.loreName2,
      required this.loreDescription2,
      required this.loreName3,
      required this.loreDescription3,
      required this.loreName4,
      required this.loreDescription4,
      required this.loreName5,
      required this.loreDescription5,
      required this.createdAt,
      required this.updatedAt,
      required this.publishedAt});

  factory AntiquitiesDataAttr.fromJson(Map<String, dynamic> json) =>
      _$AntiquitiesDataAttrFromJson(json);

  Map<String, dynamic> toJson() => _$AntiquitiesDataAttrToJson(this);
}

@JsonSerializable()
class AntiquitiesData {
  int id;
  AntiquitiesDataAttr attributes;

  AntiquitiesData({required this.id, required this.attributes});

  factory AntiquitiesData.fromJson(Map<String, dynamic> json) =>
      _$AntiquitiesDataFromJson(json);

  Map<String, dynamic> toJson() => _$AntiquitiesDataToJson(this);
}

@JsonSerializable()
class AntiquitiesResponse {
  AntiquitiesMeta meta;
  List<AntiquitiesData> data;

  AntiquitiesResponse({required this.meta, required this.data});

  factory AntiquitiesResponse.fromJson(Map<String, dynamic> json) =>
      _$AntiquitiesResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AntiquitiesResponseToJson(this);
}
