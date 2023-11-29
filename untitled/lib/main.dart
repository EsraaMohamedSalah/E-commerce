import 'package:flutter/material.dart';
import 'package:untitled/screens/login_screen.dart';
import 'package:untitled/screens/signup_screen.dart';
import 'package:untitled/home_page.dart';

import 'auth_service.dart';

void main() {
  runApp(MyApp());
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

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}
class _MyHomePageState extends State<MyHomePage> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Theme.of(context).scaffoldBackgroundColor,

        child: Padding(
          padding: EdgeInsets.only(top: 50), // Adjust the value as needed
          child: Column(
            children: [
              Container(
                color: Colors.transparent,
                child: TabBar(
                  controller: _tabController,
                  tabs: [
                    _buildTab('Sign Up'),
                    _buildTab('Log In'),
                    _buildTab('Forgot Password'),
                  ],
                  labelColor: Color(0xFF515C6F),
                  unselectedLabelColor: Colors.black.withOpacity(0.3),
                  indicator: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(width: 0.0, color: Colors.transparent),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  color: Theme.of(context).scaffoldBackgroundColor,

                  child: TabBarView(

                    controller: _tabController,
                    children: [
                      _buildTabContent('Email'),
                      _buildTabContent('UserName'),
                      _buildTabContent('Password'),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  Widget _buildTab(String text) {
    return Tab(
      child: Text(
        text,
        style: TextStyle(
          fontSize: 30,
          fontWeight: FontWeight.bold,
        // color: Color(0xFF515C6F),
        ),
      ),
    );
  }

  Widget _buildTabContent(String title) {
    return Container(
      padding: EdgeInsets.all(20),
      color: Theme.of(context).scaffoldBackgroundColor,
      child: Column(
        children: [
          _buildTextFieldWithIcon(Icons.email_outlined, 'Email', false,true,true),
          _buildTextFieldWithIcon(Icons.person_2_outlined, 'UserName', false,false,false),
          _buildTextFieldWithIcon(Icons.lock_outline, 'Password', true,false,false),
          SizedBox(height: 20),
          _buildSignUpButton(),
          SizedBox(height: 20),
          RichText(
            text: TextSpan(
              text: 'By creating an account, you agree to our ',
              style: TextStyle(
                color:  Color(0xFF515C6F),
              ),
              children: [
                TextSpan(
                  text: 'Terms of Service ',
                  style: TextStyle(
                    color: Color(0xFFFF6969),
                  ),
                ),
                TextSpan(
                  text: ' and ',
                  style: TextStyle(
                    color:  Color(0xFF515C6F),
                  ),
                ),TextSpan(
                  text: 'Conditions ',
                  style: TextStyle(
                    color: Color(0xFFFF6969),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextFieldWithIcon(IconData icon, String title, bool hasBottomBorder,bool hasupRadius,bool hasspacing  ) {
    return Container(
      width: 800,
      margin: EdgeInsets.only(bottom: hasspacing ? 1 : 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        color: Colors.white,
      ),
      child: TextField(
        decoration: InputDecoration(
          prefixIcon: Icon(icon,color: Color(0xFF727C8E),size: 25),
          labelStyle:TextStyle(color: Color(0xFF727C8E)),
          labelText: title,
          //border:InputBorder.none,
          fillColor: Colors.white,
          filled: true,
          border: OutlineInputBorder(
            borderRadius: hasupRadius
                ? BorderRadius.only(
              topLeft: Radius.circular(10.0),
              topRight: Radius.circular(10.0),
            )
                :hasBottomBorder? BorderRadius.only(
              bottomLeft: Radius.circular(10.0),
               bottomRight: Radius.circular(10.0),
            ):BorderRadius.only(
              topLeft: Radius.circular(0.0),
              topRight: Radius.circular(0.0),
               bottomLeft: Radius.circular(0.0),
               bottomRight: Radius.circular(0.0),
            ),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }

  Widget _buildSignUpButton() {
    return Container(
      width: 800,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Color(0xFFFF6969), // Change the color as needed
      ),
      child: TextButton(
        onPressed: () {
          // Add your signup logic here
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Sign Up',
              style: TextStyle(color: Colors.white),
            ),
            SizedBox(width: 10),
            Container(
              padding: EdgeInsets.all(1),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,

              ),
              child: Icon(
                Icons.arrow_forward_ios,
                size: 20,
                color:  Color(0xFFFF6969), // Change the color as needed
              ),
            ),
            //Icon(Icons.arrow_forward_rounded, color: Colors.white),
          ],
        ),
      ),
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