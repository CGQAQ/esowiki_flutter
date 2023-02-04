import "dart:convert";

import "package:http/http.dart" as http;
import "package:json_annotation/json_annotation.dart";
import "consts.dart";

part "articles.g.dart";

Future<ArticlesAttributes> getArticleById(String id) async {
  String url = "$API_PREFIX/articles/$id";

  final resp =
      await http.get(Uri.parse(url)).then((value) => jsonDecode(value.body));
  final article = Article.fromJson(resp);

  String? normalizedUrl(String? str) {
    if (str?.startsWith("//")??false) {
      return "https:$str";
    } else {
      return str;
    }
  }

  article.data.attributes.thumb = normalizedUrl(article.data.attributes.thumb);

  return article.data.attributes;
}

@JsonSerializable()
class ArticleData {
  int id;
  ArticlesAttributes attributes;

  ArticleData({required this.id, required this.attributes});

  factory ArticleData.fromJson(Map<String, dynamic> json) =>
      _$ArticleDataFromJson(json);

  Map<String, dynamic> toJson() => _$ArticleDataToJson(this);
}
@JsonSerializable()
class Article {
  ArticleData data;

  Article({required this.data});

  factory Article.fromJson(Map<String, dynamic> json) =>
      _$ArticleFromJson(json);

  Map<String, dynamic> toJson() => _$ArticleToJson(this);
}

Future<ArticlesResponse> getArticles({
  int pageCurrent = 0,
  int pageSize = 20,
  String keyword = "",
}) async {
  String url =
      "$API_PREFIX/articles?pagination[page]=$pageCurrent&pagination[pageSize]=$pageSize&filters[title][\$containsi]=$keyword";

  final resp =
      await http.get(Uri.parse(url)).then((value) => jsonDecode(value.body));
  final articles = ArticlesResponse.fromJson(resp);

  for (final article in articles.data) {
    String? normalizedUrl(String? str) {
      if (str?.startsWith("//")??false) {
        return "https:$str";
      } else {
        return str;
      }
    }

    article.attributes.thumb = normalizedUrl(article.attributes.thumb);
  }

  return articles;
}

@JsonSerializable()
class ArticlesMetaPagination {
  int page;
  int pageSize;
  int pageCount;
  int total;

  ArticlesMetaPagination(
      {required this.page,
      required this.pageSize,
      required this.pageCount,
      required this.total});

  factory ArticlesMetaPagination.fromJson(Map<String, dynamic> json) =>
      _$ArticlesMetaPaginationFromJson(json);

  Map<String, dynamic> toJson() => _$ArticlesMetaPaginationToJson(this);
}

@JsonSerializable()
class ArticlesMeta {
  ArticlesMetaPagination pagination;

  ArticlesMeta({required this.pagination});

  factory ArticlesMeta.fromJson(Map<String, dynamic> json) =>
      _$ArticlesMetaFromJson(json);

  Map<String, dynamic> toJson() => _$ArticlesMetaToJson(this);
}

@JsonSerializable()
class ArticlesAttributes {
  String? title;
  String? description;
  String? content;
  String? thumb;

  ArticlesAttributes(
      {required this.title,
      required this.description,
      required this.content,
      required this.thumb});

  factory ArticlesAttributes.fromJson(Map<String, dynamic> json) =>
      _$ArticlesAttributesFromJson(json);

  Map<String, dynamic> toJson() => _$ArticlesAttributesToJson(this);
}

@JsonSerializable()
class ArticlesRelationships {
  ArticlesRelationships();

  factory ArticlesRelationships.fromJson(Map<String, dynamic> json) =>
      _$ArticlesRelationshipsFromJson(json);

  Map<String, dynamic> toJson() => _$ArticlesRelationshipsToJson(this);
}

@JsonSerializable()
class ArticlesData {
  String id;
  String type;
  ArticlesAttributes attributes;
  ArticlesRelationships relationships;

  ArticlesData(
      {required this.id,
      required this.type,
      required this.attributes,
      required this.relationships});

  factory ArticlesData.fromJson(Map<String, dynamic> json) =>
      _$ArticlesDataFromJson(json);

  Map<String, dynamic> toJson() => _$ArticlesDataToJson(this);
}

@JsonSerializable()
class ArticlesResponse {
  ArticlesMeta meta;
  List<ArticlesData> data;

  ArticlesResponse({required this.meta, required this.data});

  factory ArticlesResponse.fromJson(Map<String, dynamic> json) =>
      _$ArticlesResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ArticlesResponseToJson(this);
}