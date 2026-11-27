// To parse this JSON data, do
//
//     final item = itemFromJson(jsonString);

import 'dart:convert';

List<Item> itemFromJson(String str) => List<Item>.from(json.decode(str).map((x) => Item.fromJson(x)));

String itemToJson(List<Item> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Item {
    final String id;
    final String name;
    final int price;
    final String description;
    final String category;
    final String? image;
    final String seller;

    Item({
        required this.id,
        required this.name,
        required this.price,
        required this.description,
        required this.category,
        required this.image,
        required this.seller,
    });

    factory Item.fromJson(Map<String, dynamic> json) => Item(
        id: json["id"],
        name: json["name"],
        price: json["price"],
        description: json["description"],
        category: json["category"],
        image: json["image"],
        seller: json["seller"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "price": price,
        "description": description,
        "category": category,
        "image": image,
        "seller": seller,
    };
}
