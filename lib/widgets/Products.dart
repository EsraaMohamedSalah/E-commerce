import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'ProductDetailsPage.dart';


class Products extends ChangeNotifier{
  final String image;
  final String link;
  final String name;
  final String description;
  final String price;
  final String quantity;
  final String categoryId;
final List<String> color;
final List<String> size;
  final List<String> images;


  Products({
    required this.image,
    required this.link,
    required this.description,
    required this.categoryId,
    required this.name,
    required this.price,
    required this.quantity,
    required this.color,
    required this.size,
    required this.images,

  });
  factory Products.fromFirestore(DocumentSnapshot<Map<String, dynamic>> snapshot) {
    Map<String, dynamic> json = snapshot.data() ?? {};
    return Products.fromJson(json);
  }
  factory Products.fromJson(Map<String, dynamic> json) {
    List<String> colorList = (json['color'] as List<dynamic>).map((e) => e.toString()).toList();
    List<String> sizeList = (json['size'] as List<dynamic>).map((e) => e.toString()).toList();
    List<String> imagelist= (json['images'] as List<dynamic>).map((e) => e.toString()).toList();

    return Products(
      image: json['image'] ?? '',
      link: json['link'] ?? '',
      description: json['description']??'',
      name: json['name']??'',
      categoryId: json['categoryId']??'',
      price: json['price']??'',
      quantity: json['quantity']??'',
      color: colorList,
      size: sizeList,
      images: imagelist,

    );

  }
  void updateProductData() {
    // Perform any necessary state updates
    notifyListeners();
  }
  @override
  Widget build(BuildContext context) {
    return MouseRegion(
        cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () {
          // Navigate to ProductDetailsPage when tapping on the product
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ProductDetailsPage(product: this),
            ),
          );
        },
        child: Container(
          //margin: EdgeInsets.all(1),
          width: 100.0, // Set your preferred width
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Column(
            //crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 100.0, // Set your preferred image width
                height: 100.0, // Set your preferred image height
                decoration: BoxDecoration(
                  //shape: BoxShape.circle, // Make it a circle (optional)
                  image: DecorationImage(
                    image: NetworkImage(image),
                    fit: BoxFit.contain,
                    alignment: Alignment.center, // Center the image
                  ),
                ),
              ),
              SizedBox(height: 8.0),
          Container(
            margin: EdgeInsets.all(1),
            width: 130.0, // Set your preferred width
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Padding(
              padding: EdgeInsets.only(left: 8.0), // Adjust the left padding as needed
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 8.0),
                  Text(
                    name,
                    style: TextStyle(fontSize: 12.0,color: Color(0xFF515C6F)),
                    textAlign: TextAlign.left,
                  ),
                  Text(
                    price,
                    style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.bold,color: Color(0xFF515C6F)),
                    textAlign: TextAlign.left,
                  ),
                ],
              ),
            ),


          )],
          ),
        ),
      ),
    );
  }
}
