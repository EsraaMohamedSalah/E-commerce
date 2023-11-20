// In home_page.dart
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'auth_service.dart';

class HomePage extends StatelessWidget {
  final AuthService authService = AuthService();

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
      body: Container(
        decoration: const BoxDecoration(
          color: Colors.pink,
          image: DecorationImage(
            image: AssetImage('assets/home-page.jpg'),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
