// In home_page.dart
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled/newlogin.dart';
import 'package:untitled/screens/AdDetailsPage.dart';
import 'package:untitled/widgets/Ad.dart';
import 'package:untitled/widgets/Products.dart';
import 'package:untitled/widgets/carousel_slider_widget.dart';
import 'package:untitled/widgets/common_widgets.dart';
import 'dart:convert';
import 'auth_service.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final AuthService authService = AuthService();
  List<Ad> ads = [];
  List<Products> products = [];

  @override
  void initState() {
    super.initState();
    // Load and decode the JSON file
    loadCarouselData();
    loadProductData();
  }
  Future<void> loadProductData() async {
    // Replace 'data.json' with the path to your JSON file
    String jsonString =
    await DefaultAssetBundle.of(context).loadString('assets/data/data.json');
    Map<String, dynamic> data = json.decode(jsonString);

    List<dynamic> productsList = data['products'];
    setState(() {
      products = productsList.map((product) => Products.fromJson(product)).toList();
    });
  }
  Future<void> loadCarouselData() async {
    String jsonString =
        await DefaultAssetBundle.of(context).loadString('assets/data/data.json');
    Map<String, dynamic> data = json.decode(jsonString);

    List<dynamic> adsList = data['ads'];
    setState(() {
      ads = adsList.map((ad) => Ad.fromJson(ad)).toList();
    });
  }

  int _currentCarouselIndex = 0;

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
        body: Padding(
          padding: EdgeInsets.symmetric(vertical: 16.0), // Adjust vertical padding as needed
          child: Center(
            child: Column(children: [
              CarouselSlider(
                options: CarouselOptions(
                  height: 250.0,
                  enlargeCenterPage: true,
                  autoPlay: true,
                  onPageChanged: (index, reason) {
                    setState(() {
                      _currentCarouselIndex = index;
                    });
                  },
                ),
                items: ads.map((ad) {
                  return Builder(
                    builder: (BuildContext context) {
                      return MouseRegion(
                          cursor: SystemMouseCursors.click,
                          child: GestureDetector(
                            onTap: () {
                              // Navigate to AdDetailsPage when tapping on an ad
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      AdDetailsPage(adId: ad.link),
                                ),
                              );
                            },
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                Container(
                                   width: MediaQuery.of(context).size.width,
                             height:
                                      MediaQuery.of(context).size.height,
                                  margin: EdgeInsets.symmetric(horizontal: 5.0),
                                  decoration: BoxDecoration(
                                    color: Colors.transparent,
                                    borderRadius: BorderRadius.circular(8.0),
                                    image: DecorationImage(
                                      image: AssetImage(ad.image ?? ''),
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.all(16.0),
                                  width:MediaQuery.of(context).size.width ,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SizedBox(height: 8.0),
                                      Text(
                                        ad.description ?? '',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20.0,
                                        ),
                                      ),
                                      SizedBox(height: 16.0),
                                      CommonWidgets.buildSeeMoreButton()
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ));
                    },
                  );
                }).toList(),
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: ads.asMap().entries.map((entry) {
                  return GestureDetector(
                    onTap: () => _moveToCarouselIndex(entry.key),
                    child: Container(
                      width: 10.0,
                      height: 10.0,
                      margin:
                          EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: _currentCarouselIndex == entry.key
                            ? Colors.amber
                            : Colors.grey,
                      ),
                    ),
                  );
                }).toList(),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,

                children: products.asMap().entries.map((entry) {
                  return Row(
                    children: [
                      entry.value.build(context),
                      if (entry.key != products.length - 1)
                        SizedBox(width: 13.0), // Adjust the width as needed
                    ],
                  );
                }).toList(),
              ),
            ]),
          ),
        ));
  }

  void _moveToCarouselIndex(int index) {
    setState(() {
      _currentCarouselIndex = index;
    });
  }
}
