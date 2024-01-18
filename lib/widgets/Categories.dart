import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../screens/allcategoriespage.dart';
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
    return InkWell(
      onTap: () {
        if (title == 'See All') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AllCategoriesPage()),
          );
        } else {
          // Handle click for other categories
          // You can navigate to a specific category page or perform any other action
        }
      },
      child: Column(
      
        children: [
          Container(
            width: 65, // Adjust the size as needed
            height: 65, // Adjust the size as needed
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
                      colors: colors != null && colors!.isNotEmpty
                          ? colors!.map((color) => hexColor(color)).toList()
                          : [Colors.white, Colors.white], // Default colors
                      begin: Alignment.bottomLeft,
                      end: Alignment.topRight,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: hexColor(shadowColor ?? ''),
                        blurRadius: 10,
                        offset: Offset(0, 1),
                      ),
                    ],
                  ),
                ),
      
                // Image in the middle
                Positioned(
                  child: Image.network(
                    image ?? '',
                    width: 50, // Adjust the size as needed
                    height: 50, // Adjust the size as needed
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(height: 10),
      
                // Text below the circle
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            child: Text(
              title ?? '',
              style: TextStyle(
                color: Color(0XFF515C6F), // Adjust the text color as needed
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

