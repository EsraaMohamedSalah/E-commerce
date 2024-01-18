import 'package:flutter/material.dart';
import '../auth_service.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_textfield.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState  extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final AuthService authService = AuthService();

  @override
  void initState() {
    super.initState();
    checkLoginStatus();
  }
  void checkLoginStatus() async {
    bool isLoggedIn = await authService.isLoggedIn();

    if (isLoggedIn) {
      // User is already logged in, navigate to the main page
      Navigator.pushReplacementNamed(context, '/main');
    }
  }
  void loginUser() async {
    try {
      await authService.loginUser(emailController.text, passwordController.text);
      // Navigate to the main page
      Navigator.pushReplacementNamed(context, '/main');
    } catch (e) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Invalid Login'),
          content: const Text('Please enter a valid email and password.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  }
  @override

  Widget build(BuildContext context) {
    return Scaffold(

      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/image-ecommerce.webp'),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 50),

              //FlutterLogo(size: 100, textColor: Colors.red),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  Image.asset(
                    'assets/logo2.png',
                    width: 70,
                    height: 50,
                  ),
                  const SizedBox(width: 1),
                  const Text(
                    'Shopimy',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              CustomTextField(
                controller: emailController,
                labelText: 'Email',
                fontSize: 12.0,

                width: 180.0,

              ),
              const SizedBox(height: 20),
              CustomTextField(
                controller: passwordController,
                labelText: 'Password',
                fontSize: 12.0,

                width: 180.0,


                obscureText: true,
              ),
              const SizedBox(height: 20),
              CustomButton(
                onPressed: loginUser,
                text: 'Login',
                backgroundColor: Colors.blue
                ,
                textColor: Colors.white,
              ),
              const SizedBox(height: 10),
              GestureDetector(
                onTap: () {
                  // Navigate to the signup page
                  Navigator.pushNamed(context, '/signup');
                },
                child: const Text(
                  'Don\'t have an account? Sign Up',
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: 12,
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



