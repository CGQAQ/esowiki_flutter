import 'dart:convert';

import "package:http/http.dart" as http;
import 'package:json_annotation/json_annotation.dart';

part "build.g.dart";

Future<BuildsResponse> getBuilds({
  int pageCurrent = 0,
  int pageSize = 20,
  String keyword = "",
  int? id = null,
}) async {
  String url =
      "https://esoapi.denohub.com/api/builds?pagination[page]=$pageCurrent&pagination[pageSize]=$pageSize&filters[title][\$containsi]=$keyword";

  url += id != null ? "&filters[id][\$eq]=$id" : "";

  var resp =
      await http.get(Uri.parse(url)).then((value) => jsonDecode(value.body));
  var summaries = BuildsResponse.fromJson(resp);

  return summaries;
}

@JsonSerializable()
class BuildsMetaPagination {
  int page;
  int pageSize;
  int pageCount;
  int total;

  BuildsMetaPagination(
      {required this.page,
      required this.pageSize,
      required this.pageCount,
      required this.total});

  factory BuildsMetaPagination.fromJson(Map<String, dynamic> json) =>
      _$BuildsMetaPaginationFromJson(json);

  Map<String, dynamic> toJson() => _$BuildsMetaPaginationToJson(this);
}

@JsonSerializable()
class BuildsMeta {
  BuildsMetaPagination pagination;

  BuildsMeta({required this.pagination});

  factory BuildsMeta.fromJson(Map<String, dynamic> json) =>
      _$BuildsMetaFromJson(json);

  Map<String, dynamic> toJson() => _$BuildsMetaToJson(this);
}

@JsonSerializable()
class BuildsDataAttr {
  String title;
  String description;
  String image;
  String content;
  String slug;
  String createdAt;
  String updatedAt;
  String publishedAt;

  BuildsDataAttr(
      {required this.title,
      required this.description,
      required this.image,
      required this.content,
      required this.slug,
      required this.createdAt,
      required this.updatedAt,
      required this.publishedAt});

  factory BuildsDataAttr.fromJson(Map<String, dynamic> json) =>
      _$BuildsDataAttrFromJson(json);

  Map<String, dynamic> toJson() => _$BuildsDataAttrToJson(this);
}

@JsonSerializable()
class BuildsData {
  int id;
  BuildsDataAttr attrs;

  BuildsData({required this.id, required this.attrs});

  factory BuildsData.fromJson(Map<String, dynamic> json) =>
      _$BuildsDataFromJson(json);

  Map<String, dynamic> toJson() => _$BuildsDataToJson(this);
}

@JsonSerializable()
class BuildsResponse {
  BuildsMeta meta;
  List<BuildsData> data;

  BuildsResponse({required this.meta, required this.data});

  factory BuildsResponse.fromJson(Map<String, dynamic> json) =>
      _$BuildsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$BuildsResponseToJson(this);
}
