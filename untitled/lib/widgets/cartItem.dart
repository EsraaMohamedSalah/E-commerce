// cart.dart

class CartItem {
  final String name;
  final String description;
  final String price;
  final String color;
  final String size;
  final String image;
  int quantity;

  CartItem({
    required this.name,
    required this.price,
    required this.color,
    required this.size,
    required this.description,
    required this.image,
    this.quantity = 1, // Set the default quantity to 1

  });
}

class Cart {
  List<CartItem> items = [];

  void addToCart(CartItem item) {
    items.add(item);
  }
}
