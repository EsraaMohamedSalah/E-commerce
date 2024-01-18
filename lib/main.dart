import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled/screens/login_screen.dart';
import 'package:untitled/screens/signup_screen.dart';
import 'package:untitled/home_page.dart';
import 'package:untitled/widgets/cart_provider.dart';
import 'package:untitled/widgets/notification_provider.dart';

import 'app_data_provider.dart';
import 'auth_service.dart';
import 'newlogin.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: FirebaseOptions(
      apiKey: 'AIzaSyAkuv66pmxljQMpFv1UB-7lnIFnKnJM8f4',
      authDomain: 'e-commerce-a4590.firebaseapp.com',
      projectId: 'e-commerce-a4590',
      storageBucket: 'e-commerce-a4590.appspot.com',
      messagingSenderId: 'your_messaging_sender_id',
      appId: 'com.example.untitled',
    ),
  );// Initialize Firebase
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthService>(create: (context) => AuthService()),
        ChangeNotifierProvider<AppDataProvider>(create: (context) => AppDataProvider()),
        ChangeNotifierProvider<NotificationProvider>(create: (context) => NotificationProvider()),

        ChangeNotifierProvider(create: (context) => CartProvider()),],
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