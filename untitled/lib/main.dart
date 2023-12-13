import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled/screens/login_screen.dart';
import 'package:untitled/screens/signup_screen.dart';
import 'package:untitled/home_page.dart';

import 'app_data_provider.dart';
import 'auth_service.dart';
import 'newlogin.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => AppDataProvider(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override

  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.grey[100],
      ),
      home: MyHomePage(),
    );
  }
    /*return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'E-commerce App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.white,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => SplashScreen(),
        '/login': (context) => LoginScreen(),
        '/signup': (context) => SignupScreen(),
        '/main': (context) => HomePage(),

      },
    );
  }*/
}


class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: AuthService().isLoggedIn(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else {
          if (snapshot.data == true) {
            // User is logged in, navigate to the main page
            return HomePage();
          } else {
            // User is not logged in, navigate to the login page
            return LoginScreen();
          }
        }
      },
    );
  }
}