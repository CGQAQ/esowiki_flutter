import 'dart:convert';

import "package:http/http.dart" as http;
import 'package:json_annotation/json_annotation.dart';

part "summaries.g.dart";

Future<SummariesResponse> getSummaries({
  int pageCurrent = 0,
  int pageSize = 20,
  String keyword = "",
}) async {
  String url =
      "https://esoapi.denohub.com/api/set-summaries?pagination[page]=$pageCurrent&pagination[pageSize]=$pageSize&filters[name][\$containsi]=$keyword";

  var resp =
      await http.get(Uri.parse(url)).then((value) => jsonDecode(value.body));
  var summaries = SummariesResponse.fromJson(resp);

  return summaries;
}

@JsonSerializable()
class SummariesMetaPagination {
  int page;
  int pageSize;
  int pageCount;
  int total;

  SummariesMetaPagination(
      {required this.page,
      required this.pageSize,
      required this.pageCount,
      required this.total});

  factory SummariesMetaPagination.fromJson(Map<String, dynamic> json) =>
      _$SummariesMetaPaginationFromJson(json);

  Map<String, dynamic> toJson() => _$SummariesMetaPaginationToJson(this);
}

@JsonSerializable()
class SummariesMeta {
  SummariesMetaPagination pagination;

  SummariesMeta({required this.pagination});

  factory SummariesMeta.fromJson(Map<String, dynamic> json) =>
      _$SummariesMetaFromJson(json);

  Map<String, dynamic> toJson() => _$SummariesMetaToJson(this);
}

@JsonSerializable()
class SummariesDataAttr {
  //         "name": "熟练骑手",
  String name;
  //         "type": "Crafted",
  String type;
  //         "itemCount": 370,
  int itemCount;
  //         "setBonusCount": 4,
  int setBonusCount;
  //         "setMaxEquipCount": 5,
  int setMaxEquipCount;
  //         "gameId": 385,
  int gameId;
  //         "setBonusDesc1": "（2件）增加34-1487盔甲",
  String setBonusDesc1;
  //         "setBonusDesc2": "（3件）增加34-1487盔甲",
  String setBonusDesc2;
  //         "setBonusDesc3": "（4件）增加28-1206生命上限",
  String setBonusDesc3;
  //         "setBonusDesc4": "（5件）始终获得高级疾驰与高级迅敏，移动速度与骑乘速度提高30%。",
  String setBonusDesc4;
  //         "setBonusDesc5": "",
  String setBonusDesc5;
  //         "setBonusDesc6": "",
  String setBonusDesc6;
  //         "setBonusDesc7": "",
  String setBonusDesc7;
  //         "itemSlots": "Neck Ring Medium(All)光(All)重型(All) Shield Weapons(All)",
  String itemSlots;
  //         "createdAt": "2022-12-02T06:55:12.980Z",
  String createdAt;
  //         "updatedAt": "2022-12-02T08:32:54.088Z",
  String updatedAt;
  //         "publishedAt": "2022-12-02T06:55:12.977Z"
  String publishedAt;
  // "nameEn": "Claw of the Forest Wraith",
  String nameEn;
  // "slug": "claw-of-the-forest-wraith",
  String slug;
  // "icon": "https://esoicons.uesp.net/esoui/art/icons/gear_breton_light_head_d.png"
  String? icon;

  SummariesDataAttr(
      {required this.name,
      required this.type,
      required this.itemCount,
      required this.setBonusCount,
      required this.setMaxEquipCount,
      required this.gameId,
      required this.setBonusDesc1,
      required this.setBonusDesc2,
      required this.setBonusDesc3,
      required this.setBonusDesc4,
      required this.setBonusDesc5,
      required this.setBonusDesc6,
      required this.setBonusDesc7,
      required this.itemSlots,
      required this.createdAt,
      required this.updatedAt,
      required this.publishedAt,
      required this.nameEn,
      required this.slug,
      this.icon});

  factory SummariesDataAttr.fromJson(Map<String, dynamic> json) =>
      _$SummariesDataAttrFromJson(json);

  Map<String, dynamic> toJson() => _$SummariesDataAttrToJson(this);
}

@JsonSerializable()
class SummariesData {
  int id;
  SummariesDataAttr attributes;

  SummariesData({required this.id, required this.attributes});

  factory SummariesData.fromJson(Map<String, dynamic> json) =>
      _$SummariesDataFromJson(json);

  Map<String, dynamic> toJson() => _$SummariesDataToJson(this);
}

@JsonSerializable()
class SummariesResponse {
  // {
  //     "id": 1,
  //     "attributes": {
  //         "name": "熟练骑手",
  //         "type": "Crafted",
  //         "itemCount": 370,
  //         "setBonusCount": 4,
  //         "setMaxEquipCount": 5,
  //         "gameId": 385,
  //         "setBonusDesc1": "（2件）增加34-1487盔甲",
  //         "setBonusDesc2": "（3件）增加34-1487盔甲",
  //         "setBonusDesc3": "（4件）增加28-1206生命上限",
  //         "setBonusDesc4": "（5件）始终获得高级疾驰与高级迅敏，移动速度与骑乘速度提高30%。",
  //         "setBonusDesc5": "",
  //         "setBonusDesc6": "",
  //         "setBonusDesc7": "",
  //         "itemSlots": "Neck Ring Medium(All)光(All)重型(All) Shield Weapons(All)",
  //         "createdAt": "2022-12-02T06:55:12.980Z",
  //         "updatedAt": "2022-12-02T08:32:54.088Z",
  //         "publishedAt": "2022-12-02T06:55:12.977Z"
  //         "nameEn": "Claw of the Forest Wraith",
  //         "slug": "claw-of-the-forest-wraith",
  //         "icon": "https://esoicons.uesp.net/esoui/art/icons/gear_breton_light_head_d.png"
  //    }
  // },
  List<SummariesData> data;

  ///  "meta": {
  ///      "pagination": {
  ///          "page": 1,
  ///          "pageSize": 10,
  ///          "pageCount": 59,
  ///         "total": 585
  ///      }
  /// }
  SummariesMeta meta;

  SummariesResponse({required this.data, required this.meta});

  factory SummariesResponse.fromJson(Map<String, dynamic> json) =>
      _$SummariesResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SummariesResponseToJson(this);
}
