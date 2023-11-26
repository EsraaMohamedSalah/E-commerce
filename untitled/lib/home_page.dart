// In home_page.dart
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled/widgets/carousel_slider_widget.dart';

import 'auth_service.dart';

class HomePage extends StatelessWidget {
  final AuthService authService = AuthService();
  final List<String> images = [
    'assets/clothes1.jpg',
    'assets/clothes2.jpg',
    'assets/clothes3.webp',
    'assets/clothes4.webp',
    'assets/clothes5.jpg',

  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
        centerTitle: true,

        backgroundColor: Colors.amberAccent,

        actions: [
          GestureDetector(
            onTap: () async {
              await authService.logout();
              Navigator.pushReplacementNamed(context, '/login');
            },
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Center(
                child: Text(
                  'Logout',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
        ],
      ),
      body: Center(
        child:CarouselSliderWidget<String>(
          items: images,
          itemBuilder: (imagePath) {
            return Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(imagePath),
                  fit: BoxFit.fitHeight,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
