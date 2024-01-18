// cart_provider.dart

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'cartItem.dart';
import 'cartpage.dart';
import 'orderItem.dart';

class CartProvider extends ChangeNotifier {
  List<CartItem> _items = [];

  List<CartItem> get items => _items;
  List<OrderItem> convertToOrderItems() {
    return items.map((cartItem) {
      return OrderItem(
        name: cartItem.name,
        description: cartItem.description,
        image: cartItem.image,
        color: cartItem.color,
        size: cartItem.size,
        price: cartItem.price,
      );
    }).toList();
  }
  void addToCart(CartItem item) {
    //_items.add(item);
    bool found = false;
    for (CartItem existingItem in _items) {
      if (_isSameItem(existingItem, item)) {
        // If the item is already in the cart, update the quantity
        existingItem.quantity += 1;
        found = true;
        break;
      }
    }

    // If the item is not found in the cart, add it
    if (!found) {
      _items.add(item);
    }

    notifyListeners();
  }
  void increaseQuantity(CartItem item) {
    item.quantity += 1;
    notifyListeners();
    recalculateTotal();

  }

  void decreaseQuantity(CartItem item) {
    if (item.quantity > 0) {
      item.quantity -= 1;
      notifyListeners();
      recalculateTotal();

    }
  }
  bool _isSameItem(CartItem item1, CartItem item2) {
    return
        item1.name == item2.name &&
        item1.color == item2.color &&
        item1.description == item2.description &&
        item1.size == item2.size
    && item1.price == item2.price;
  }
  double recalculateTotal() {
    double total = 0;
    for (CartItem item in _items) {
      String priceWithoutSymbol = item.price.replaceAll('\$', '');
      total += double.parse(priceWithoutSymbol) * item.quantity;
    }

    notifyListeners();
    return total;
  }
  void clearCart() {
    _items.clear();
    notifyListeners();
  }
  Future<void> saveOrderToFirestore(List<OrderItem> orderItems) async {
    try {
      FirebaseFirestore firestore = FirebaseFirestore.instance;

      // Check if the "orders" collection already exists
      bool ordersCollectionExists = await firestore.collection('orders').get().then((value) => value.docs.isNotEmpty);

      if (!ordersCollectionExists) {
        await firestore.collection('orders').doc('placeholder').set({}); // Add a dummy document
        await firestore.collection('orders').doc('placeholder').delete(); // Delete the dummy document
      }

      CollectionReference orders = firestore.collection('orders');
      User? user = FirebaseAuth.instance.currentUser;

      DocumentReference orderRef = await orders.add({
        'userId': user?.uid, // Store the user's UID
        'timestamp': FieldValue.serverTimestamp(),
        'items': orderItems.map((orderItem) => {
          'name': orderItem.name,
          'description': orderItem.description,
          'image': orderItem.image,
          'color': orderItem.color,
          'size': orderItem.size,
          'price': orderItem.price,
        }).toList(),
      });

      print('Order added with ID: ${orderRef.id}');
    } catch (error) {
      print('Error saving order: $error');
    }
  }

  Future<Map<String, dynamic>> getOrderDetails(String orderId) async {
    DocumentSnapshot orderSnapshot = await FirebaseFirestore.instance.collection('orders').doc(orderId).get();
    return {
      'orderId': orderId,
      'items': orderSnapshot['items'],
    };
  }
}


