import 'package:flutter/material.dart';

import '../widgets/custom_button.dart';
import '../widgets/custom_textfield.dart';

class SignupScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign Up'),
        backgroundColor: Colors.orange,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
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
                  'Shopi - My',
                  style: TextStyle(
                    fontSize: 20, // Adjust the font size as needed
                    fontWeight: FontWeight.bold,
                    color: Colors.blue, // Adjust the text color
                  ),
                ),
              ],
            ),
           // FlutterLogo(size: 100, textColor: Colors.orange),

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
                // Add signup logic here
                // For simplicity, let's just navigate back to the login page
                Navigator.pop(context);
              },
              text: 'Sign Up',
              backgroundColor: Colors.orange,
              textColor: Colors.white,
            ),
            SizedBox(height: 10),
            GestureDetector(
              onTap: () {
                // Navigate to the login page
                Navigator.pushNamed(context, '/login');
              },
              child: Text(
                'Already have an account? Log In',
                style: TextStyle(
                  color: Colors.orange,
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
