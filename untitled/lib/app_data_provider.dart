import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled/widgets/Ad.dart';
import 'package:untitled/widgets/Products.dart';

class AppDataProvider extends ChangeNotifier {
  List<Ad> _ads = [];
  List<Products> _products = [];
  int _currentCarouselIndex = 0;

  List<Ad> get ads => _ads;
  List<Products> get products => _products;
  int get currentCarouselIndex => _currentCarouselIndex;

  set currentCarouselIndex(int index) {
    _currentCarouselIndex = index;
    notifyListeners();
  }

  static ChangeNotifierProvider<AppDataProvider> provider({
    required Widget child,
  }) {
    return ChangeNotifierProvider<AppDataProvider>(
      create: (_) => AppDataProvider(),
      child: child,
    );
  }

  Future<void> loadProductData(BuildContext context) async {
    String jsonString =
    await DefaultAssetBundle.of(context).loadString('assets/data/data.json');
    Map<String, dynamic> data = json.decode(jsonString);

    List<dynamic> productsList = data['products'];
    _products = productsList.map((product) => Products.fromJson(product)).toList();

    notifyListeners();
  }

  Future<void> loadCarouselData(BuildContext context) async {
    String jsonString =
    await DefaultAssetBundle.of(context).loadString('assets/data/data.json');
    Map<String, dynamic> data = json.decode(jsonString);

    List<dynamic> adsList = data['ads'];
    _ads = adsList.map((ad) => Ad.fromJson(ad)).toList();

    notifyListeners();
  }
}
