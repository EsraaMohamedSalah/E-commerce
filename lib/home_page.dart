// In home_page.dart
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled/newlogin.dart';
import 'package:untitled/screens/AdDetailsPage.dart';
import 'package:untitled/screens/profilepage.dart';
import 'package:untitled/widgets/Ad.dart';
import 'package:untitled/widgets/Categories.dart';
import 'package:untitled/widgets/CustomAppBar.dart';
import 'package:untitled/widgets/Products.dart';
import 'package:untitled/widgets/bottomnavigationwidget.dart';
import 'package:untitled/widgets/carousel_slider_widget.dart';
import 'package:untitled/widgets/cart_provider.dart';
import 'package:untitled/widgets/cartpage.dart';
import 'package:untitled/widgets/common_widgets.dart';
import 'package:untitled/widgets/notification_provider.dart';
import 'package:untitled/widgets/notificationpage.dart';
import 'dart:convert';
import 'app_data_provider.dart';
import 'auth_service.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}
List<Color> _parseColors(List<String>? colorStrings) {
  if (colorStrings == null) {
    return []; // Return an empty list if colorStrings is null
  }
  return colorStrings.map((colorString) => Color(int.parse(colorString.substring(1), radix: 16))).toList();
}
class _HomePageState extends State<HomePage> {
  final AuthService authService = AuthService();
  int _currentIndex = 0; // Index of the selected tab

  // List<Ad> ads = [];
  // List<Products> products = [];

  @override
  void initState() {
    super.initState();
    // Load and decode the JSON file
    final appDataProvider = Provider.of<AppDataProvider>(context, listen: false);
    appDataProvider.loadCarouselData(context);
    appDataProvider.loadProductData(context);
    appDataProvider.loadCategoryData(context);
    final notificationProvider = Provider.of<NotificationProvider>(context, listen: false);
    notificationProvider.loadNotificationData(context);
  }


  @override
  Widget build(BuildContext context) {
    CartProvider cartProvider = Provider.of<CartProvider>(context);
    NotificationProvider notificationProvider = Provider.of<NotificationProvider>(context);

    int cartItemCount = cartProvider.items.length;
    Color backgroundColor = Colors.white;
    int notificationCount = notificationProvider.items.length;

    return Scaffold(
        appBar: CustomAppBar(
        backgroundColor: backgroundColor,
            notificationCount: notificationCount,
        cartItemCount: cartItemCount,
        onCartPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CartPage(), // Pass the cart instance to the CartPage
              ));
        },
            onNotificationPressed:(){
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => NotificationPage(), // Pass the cart instance to the CartPage
                  ));
            }
        ),
      body: SingleChildScrollView(

        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.white, Theme.of(context).scaffoldBackgroundColor], // Adjust colors as needed
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  Text(
                    'Categories',
                    style: TextStyle(
                      fontSize: 25.0,
                      fontWeight: FontWeight.bold,
                      color: Color(0XFF515C6F),
                    ),
                  ),

                  Consumer<AppDataProvider>(
                    builder: (context, appDataProvider, child) {
                      return SizedBox(
                        height: 90.0, // Adjust the height as needed
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: appDataProvider.categories.length,
                          itemBuilder: (context, index) {
                            final category = appDataProvider.categories[index];
                            return Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8.0),
                              child: category.buildCategoryWidget(context),
                            );
                          },
                        ),
                      );
                    },
                  ),
                  SizedBox(height: 2),

                  Text(
                    'Latest',
                    style: TextStyle(
                      fontSize: 25.0,
                      fontWeight: FontWeight.bold,
                      color: Color(0XFF515C6F),
                    ),
                  ),
                  // Carousel Slider ads
                  Consumer<AppDataProvider>(
                    builder: (context, appDataProvider, child) {
                      return CarouselSlider(
                        options: CarouselOptions(
                          height: 200.0,
                          //enlargeCenterPage: true,
                          autoPlay: true,
                          onPageChanged: (index, reason) {
                            // You can handle carousel page changes here
                          },
                        ),
                        items: appDataProvider.ads.map((ad) {
                          return Builder(
                            builder: (BuildContext context) {
                              return MouseRegion(
                                cursor: SystemMouseCursors.click,
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => AdDetailsPage(adId: ad.link),
                                      ),
                                    );
                                  },
                                  child: Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      Container(
                                        //width: MediaQuery.of(context).size.width,
                                       // height: MediaQuery.of(context).size.height,
                                       // margin: EdgeInsets.symmetric(horizontal: 5.0),
                                        decoration: BoxDecoration(
                                          color: Colors.transparent,
                                          borderRadius: BorderRadius.circular(8.0),
                                          image: DecorationImage(
                                            image: NetworkImage(ad.image ?? ''),
                                            fit: BoxFit.contain,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        //padding: EdgeInsets.all(16.0),
                                        width: MediaQuery.of(context).size.width,
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.center,
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
                                            CommonWidgets.buildSeeMoreButton(),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        }).toList(),
                      );
                    },
                  ),

                    // Indicator Dots under ads
                    // Consumer<AppDataProvider>(
                    //   builder: (context, appDataProvider, child) {
                    //     return Row(
                    //       mainAxisAlignment: MainAxisAlignment.center,
                    //       children: appDataProvider.ads.asMap().entries.map((entry) {
                    //         return GestureDetector(
                    //           onTap: () => _moveToCarouselIndex(entry.key),
                    //           child: Container(
                    //             width: 10.0,
                    //             height: 10.0,
                    //             margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                    //             decoration: BoxDecoration(
                    //               shape: BoxShape.circle,
                    //               color: appDataProvider.currentCarouselIndex == entry.key
                    //                   ? Colors.amber
                    //                   : Colors.grey,
                    //             ),
                    //           ),
                    //         );
                    //       }).toList(),
                    //     );
                    //   },
                    // ),


                    // Products section
                    Consumer<AppDataProvider>(
                      builder: (context, appDataProvider, child) {
                        return Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: appDataProvider.products.asMap().entries.map((entry) {
                              return Row(
                                children: [
                                  entry.value.build(context),
                                  if (entry.key != appDataProvider.products.length - 1)
                                    SizedBox(width: 13.0),
                                ],
                              );
                            }).toList(),
                          ),
                        );
                      },
                    ),


                  ]),
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationWidget(
        currentIndex: _currentIndex,
      ),
        );
  }
  void _moveToCarouselIndex(int index) {
    final appDataProvider = Provider.of<AppDataProvider>(context, listen: false);
    appDataProvider.currentCarouselIndex = index;
  }

}
