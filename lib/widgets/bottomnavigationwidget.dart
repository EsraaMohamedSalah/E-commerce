// bottom_navigation_widget.dart

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:untitled/home_page.dart';
import 'package:untitled/widgets/cartpage.dart';

import '../screens/profilepage.dart';

class BottomNavigationWidget extends StatefulWidget {
  final int currentIndex;

  const BottomNavigationWidget({Key? key, required this.currentIndex})
      : super(key: key);

  @override
  _BottomNavigationWidgetState createState() => _BottomNavigationWidgetState();
}

class _BottomNavigationWidgetState extends State<BottomNavigationWidget> {
  void _handleBottomNavigationTap(BuildContext context, int index) async {
    switch (index) {
      case 3: // Profile icon tapped
        User? user = FirebaseAuth.instance.currentUser;

        if (user != null) {
          String userEmail = user.email ?? "";

          QuerySnapshot<Map<String, dynamic>> userSnapshot =
          await FirebaseFirestore.instance
              .collection('users')
              .where('email', isEqualTo: userEmail)
              .limit(1)
              .get();
          if (userSnapshot.docs.isNotEmpty) {
            var userData = userSnapshot.docs[0].data();
            String userName = userData['username'] ?? "";
            String profilePictureUrl = userData['photoUrl'] ?? "";

            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProfilePage(
                  email: userEmail,
                  username: userName,
                  photoUrl: profilePictureUrl,
                ),
              ),
            );
          } else {
            // Handle the case where no matching document is found
          }
        } else {
          // The user is not signed in
        }
        break;
      case 0:
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => HomePage( ),
          ),
        );
        break;
      case 2:
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CartPage( ),
          ),
        );
        break;
    // Handle other cases as needed
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: widget.currentIndex,
        onTap: (index) => _handleBottomNavigationTap(context, index),
        selectedItemColor: Color(0xFFFF6969),
        unselectedItemColor: Colors.grey,
        selectedFontSize: 8.0,
        unselectedFontSize: 8.0,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart_outlined),
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline_rounded),
            label: 'Profile',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.menu),
            label: 'More',
          ),
        ],
      ),
    );
  }
}
