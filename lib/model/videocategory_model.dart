// To parse this JSON data, do
//
//     final videoModel = videoModelFromJson(jsonString);

import 'dart:convert';

VideoModel videoModelFromJson(String str) => VideoModel.fromJson(json.decode(str));

String videoModelToJson(VideoModel data) => json.encode(data.toJson());

class VideoModel {
  int status;
  List<Datum> data;

  VideoModel({
    required this.status,
    required this.data,
  });

  factory VideoModel.fromJson(Map<String, dynamic> json) => VideoModel(
    status: json["status"],
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Datum {
  int id;
  int categoryId;
  int subcategoryId;
  String name;
  String slug;
  String? description;
  String url;
  String image;
  int status;
  DateTime createdAt;
  DateTime updatedAt;
  List<dynamic> translations;

  Datum({
    required this.id,
    required this.categoryId,
    required this.subcategoryId,
    required this.name,
    required this.slug,
    required this.description,
    required this.url,
    required this.image,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.translations,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    categoryId: json["category_id"],
    subcategoryId: json["subcategory_id"],
    name: json["name"],
    slug: json["slug"],
    description: json["description"],
    url: json["url"],
    image: json["image"],
    status: json["status"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    translations: List<dynamic>.from(json["translations"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "category_id": categoryId,
    "subcategory_id": subcategoryId,
    "name": name,
    "slug": slug,
    "description": description,
    "url": url,
    "image": image,
    "status": status,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "translations": List<dynamic>.from(translations.map((x) => x)),
  };
}
