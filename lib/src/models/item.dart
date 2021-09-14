
class Item {
  String name;
  double price;
  String? description;
  String? imageLink;
  String owner;
  int? category;

  Item({
    required this.name,
    required this.price,
    required this.owner,
    this.description,
    this.imageLink,
    this.category
  });

  @override
  String toString() {
    return this.name;
  }
}