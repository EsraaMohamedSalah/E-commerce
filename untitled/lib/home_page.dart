// In home_page.dart
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled/newlogin.dart';
import 'package:untitled/screens/AdDetailsPage.dart';
import 'package:untitled/widgets/Ad.dart';
import 'package:untitled/widgets/carousel_slider_widget.dart';
import 'dart:convert';
import 'auth_service.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final AuthService authService = AuthService();
  List<Ad> ads = [];

  // final List<String> images = [
  //   'assets/clothes1.jpg',
  //   'assets/clothes2.jpg',
  //   'assets/clothes3.webp',
  //   'assets/clothes4.webp',
  //   'assets/clothes5.jpg',
  //
  // ];
  @override
  void initState() {
    super.initState();
    // Load and decode the JSON file
    loadCarouselData();
  }

    Future<void> loadCarouselData() async {
    String jsonString = await DefaultAssetBundle.of(context).loadString('/data/data.json');
    Map<String, dynamic> data = json.decode(jsonString);

    List<dynamic> adsList = data['ads'];
    setState(() {
      ads = adsList.map((ad) => Ad.fromJson(ad)).toList();
    });
  }

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
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MyHomePage(),
                ),
              );
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
        child:Column(
          children: [
        CarouselSlider(
        options: CarouselOptions(
        height: 200.0,
          enlargeCenterPage: true,
          autoPlay: true,
        ),
        items: ads.map((ad) {
          return Builder(
            builder: (BuildContext context) {
              return MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child:GestureDetector(
                onTap: () {
                  // Navigate to AdDetailsPage when tapping on an ad
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AdDetailsPage(adId: ad.link),
                    ),
                  );
                },
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.symmetric(horizontal: 5.0),
                  decoration: BoxDecoration(
                    color: Colors.amber,
                    borderRadius: BorderRadius.circular(8.0),
                    image: DecorationImage(
                      image: AssetImage(ad.image),
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                ),
              ));
            },
          );
        }).toList(),
      ),
      ]),
    ));
  }
}
