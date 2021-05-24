// To parse this JSON data, do
//
//     final details = detailsFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

Details detailsFromJson(String str) => Details.fromJson(json.decode(str));

String detailsToJson(Details data) => json.encode(data.toJson());

class Details {
  Details({
    @required this.menu,
    @required this.items,
  });

  String menu;
  List<Item> items;

  factory Details.fromJson(Map<String, dynamic> json) => Details(
        menu: json["menu"],
        items: List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "menu": menu,
        "items": List<dynamic>.from(items.map((x) => x.toJson())),
      };
}

class Item {
  Item({
    @required this.id,
    @required this.name,
    @required this.description,
    @required this.image,
    @required this.price,
  });

  int id;
  String name;
  String description;
  String image;
  String price;

  factory Item.fromJson(Map<String, dynamic> json) => Item(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        image: json["image"],
        price: json["price"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "image": image,
        "price": price,
      };
}
