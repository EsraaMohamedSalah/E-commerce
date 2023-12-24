import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'ProductDetailsPage.dart';


class Categories extends ChangeNotifier{
  String? title;
  String? description;
  String? image;
  String? shadowColor;
  List<String>? colors;


  Categories({
    required this.title,
    required this.description,
    required this.image,
    required this.shadowColor,
    required this.colors,

  });
  factory Categories.fromFirestore(DocumentSnapshot<Map<String, dynamic>> snapshot) {
    Map<String, dynamic> json = snapshot.data() ?? {};
    return Categories.fromJson(json);
  }
  factory Categories.fromJson(Map<String, dynamic> json) {
    List<String> colorList = (json['colors'] as List<dynamic>).map((e) => e.toString()).toList();

    return Categories(
      image: json['image'] ?? '',
      description: json['description']??'',
      title: json['title']??'',
      shadowColor: json['shadowColor']??'',
      colors: colorList,

    );

  }
  void updateCategoryData() {
    // Perform any necessary state updates
    notifyListeners();
  }
  @override
  Widget buildCategoryWidget(BuildContext context) {
    return Container(
      width: 120, // Adjust the size as needed
      height: 120, // Adjust the size as needed
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Circular gradient background
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                colors: colors != null && colors!.length >= 2
                    ? [Color(hexColor(colors![0]) as int), Color(hexColor(colors![1]) as int)]
                    : [Colors.white, Colors.white], // Default colors
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              boxShadow: [
                BoxShadow(
                  color: hexColor(shadowColor ?? ''),
                  blurRadius: 10,
                  offset: Offset(0, 5),
                ),
              ],
            ),
          ),

          // Image in the middle
          Positioned(
            child: Image.network(
              image ?? '',
              width: 80, // Adjust the size as needed
              height: 80, // Adjust the size as needed
              fit: BoxFit.cover,
            ),
          ),

          // Text below the circle
          Positioned(
            bottom: 0,
            child: Text(
              title ?? '',
              style: TextStyle(
                color: Colors.black, // Adjust the text color as needed
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Color hexColor(String hex) {
    hex = hex.replaceAll("#", "");
    return Color(int.parse("0xFF$hex"));
  }
}

