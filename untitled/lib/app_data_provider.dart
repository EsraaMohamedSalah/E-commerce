import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled/widgets/Ad.dart';
import 'package:untitled/widgets/Categories.dart';
import 'package:untitled/widgets/Products.dart';

class AppDataProvider extends ChangeNotifier {
  List<Ad> _ads = [];
  List<Products> _products = [];
  List<Categories> _categories = [];

  int _currentCarouselIndex = 0;

  List<Ad> get ads => _ads;
  List<Products> get products => _products;
  List<Categories> get categories => _categories;

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
    try {
      QuerySnapshot<Map<String, dynamic>> snapshot =
      await FirebaseFirestore.instance.collection('products').get();

      _products = snapshot.docs.map((doc) => Products.fromFirestore(doc)).toList();

      notifyListeners();
    } catch (error) {
      print('Error loading product data: $error');
    }
  }

  Future<void> loadCategoryData(BuildContext context) async {
    try {
      QuerySnapshot<Map<String, dynamic>> snapshot =
      await FirebaseFirestore.instance.collection('categories').get();

      _categories = snapshot.docs.map((doc) => Categories.fromFirestore(doc)).toList();

      notifyListeners();
    } catch (error) {
      print('Error loading product data: $error');
    }
  }

  Future<void> loadCarouselData(BuildContext context) async {
    try {

      QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore.instance.collection('ads').get();
     // print('Number of documents: ${snapshot.docs.length}');

      _ads = snapshot.docs.map((doc) => Ad.fromFirestore(doc)).toList();

      notifyListeners();
    } catch (error) {
      print('Error fetching ads: $error');
    }
    // String jsonString =
    // await DefaultAssetBundle.of(context).loadString('assets/data/data.json');
    // Map<String, dynamic> data = json.decode(jsonString);
    //
    // List<dynamic> adsList = data['ads'];
    // _ads = adsList.map((ad) => Ad.fromJson(ad)).toList();
    //
    // notifyListeners();
  }
}
