
class Item {
  String name;
  double price;
  String? description;
  String? imageLink;
  int? category;

  Item({
    required this.name,
    required this.price,
    this.description,
    this.imageLink,
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
      'description': description
    };
  }
}