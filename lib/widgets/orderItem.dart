class OrderItem {
  final String name;
  final String description;
  final String image;
  final String color;
  final String size;
  final String price;

  OrderItem({
    required this.name,
    required this.description,
    required this.image,
    required this.color,
    required this.size,
    required this.price,
  });
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'description': description,
      'image': image,
      'color': color,
      'size': size,
      'price': price,
    };
  }
}
