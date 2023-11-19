import 'package:flutter/material.dart';

import '../widgets/custom_button.dart';
import '../widgets/custom_textfield.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //FlutterLogo(size: 100, textColor: Colors.red),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/logo2.png',
                  width: 200, // Adjust the width as needed
                  height: 200, // Adjust the height as needed
                ),
                SizedBox(width: 10), // Add some spacing between the logo and text
                Text(
                  'ShoPi - My',
                  style: TextStyle(
                    fontSize: 20, // Adjust the font size as needed
                    fontWeight: FontWeight.bold,
                    color: Colors.blue, // Adjust the text color
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            CustomTextField(
              controller: emailController,
              labelText: 'Email',
            ),
            SizedBox(height: 20),
            CustomTextField(
              controller: passwordController,
              labelText: 'Password',
              obscureText: true,
            ),
            SizedBox(height: 20),
            CustomButton(
              onPressed: () {
                // Add authentication logic here
                // For simplicity, let's just navigate to the signup page
                Navigator.pushNamed(context, '/signup');
              },
              text: 'Login',
              backgroundColor: Colors.blue
              ,
              textColor: Colors.white,
            ),
            SizedBox(height: 10),
            GestureDetector(
              onTap: () {
                // Navigate to the signup page
                Navigator.pushNamed(context, '/signup');
              },
              child: Text(
                'Don\'t have an account? Sign Up',
                style: TextStyle(
                  color: Colors.blue,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
