
import 'dart:io';

import 'dart:typed_data';

class Item {
  String name;
  double price;
  String? description;
  dynamic image;
  int? category;

  Item({
    required this.name,
    required this.price,
    this.description,
    this.image,
    this.category
  });

  @override
  String toString() {
    return this.name;
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'price': "$price",
      'description': description,
      'image': image
    };
  }
}