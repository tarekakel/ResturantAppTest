// To parse this JSON data, do
//
//     final resturantModel = resturantModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

ResturantModel resturantModelFromJson(String str) =>
    ResturantModel.fromJson(json.decode(str));

String resturantModelToJson(ResturantModel data) => json.encode(data.toJson());

class ResturantModel {
  ResturantModel({
    @required this.id,
    @required this.name,
    @required this.cuisine,
    @required this.rate,
    @required this.status,
    @required this.prices,
    @required this.topComments,
    @required this.images,
  });

  int id;
  String name;
  String cuisine;
  int rate;
  String status;
  String prices;
  List<TopComment> topComments;
  List<String> images;

  factory ResturantModel.fromJson(Map<String, dynamic> json) => ResturantModel(
        id: json["id"],
        name: json["name"],
        cuisine: json["cuisine"],
        rate: json["rate"],
        status: json["status"],
        prices: json["prices"],
        topComments: List<TopComment>.from(
            json["top_comments"].map((x) => TopComment.fromJson(x))),
        images: List<String>.from(json["images"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "cuisine": cuisine,
        "rate": rate,
        "status": status,
        "prices": prices,
        "top_comments": List<dynamic>.from(topComments.map((x) => x.toJson())),
        "images": List<dynamic>.from(images.map((x) => x)),
      };
}

class TopComment {
  TopComment({
    @required this.body,
  });

  String body;

  factory TopComment.fromJson(Map<String, dynamic> json) => TopComment(
        body: json["body"],
      );

  Map<String, dynamic> toJson() => {
        "body": body,
      };
}
