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
        backgroundColor: Colors.blue,
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/image-ecommerce.webp'),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 50), // Add some spacing between the logo and text

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/logo2.png',
                    width: 70,
                    height: 50,
                  ),
                  SizedBox(width: 1),
                  Text(
                    'Shopimy',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                ],
              ),

              SizedBox(height: 20),
              CustomTextField(
                controller: emailController,
                labelText: 'Email',
                fontSize: 12.0,

                width: 180.0,
              ),
              SizedBox(height: 20),
              CustomTextField(
                controller: passwordController,
                labelText: 'Password',
                fontSize: 12.0, // Set the desired font size

                width: 180.0,
                obscureText: true,
              ),
              SizedBox(height: 20),
              CustomButton(
                onPressed: () {

                  Navigator.pop(context);
                },
                text: 'Sign Up',
                backgroundColor: Colors.blue,
                textColor: Colors.white,
              ),
              SizedBox(height: 10),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/login');
                },
                child: Text(
                  'Already have an account? Log In',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.blue,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
