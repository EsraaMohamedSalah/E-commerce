import 'package:flutter/material.dart';
import '../../home_page.dart';
import '../../widgets/common_widgets.dart';
import '../../auth_service.dart';

//loginScreen
class Tab2Content extends StatefulWidget {
  @override
  State<Tab2Content> createState() => _Tab2ContentState();
}

class _Tab2ContentState extends State<Tab2Content> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final AuthService authService = AuthService();

  final _formKey = GlobalKey<FormState>();
  void initState() {
    super.initState();
    checkLoginStatus();
  }
  void checkLoginStatus() async {
    bool isLoggedIn = await authService.isLoggedIn();

    if (isLoggedIn) {
      // User is already logged in, navigate to the main page
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => HomePage(),
        ),
      );
    }
  }
  void loginUser() async {
    try {
      await authService.loginUser(_emailController.text, _passwordController.text);
      // Navigate to the main page
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => HomePage(),
        ),
      );
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
    return Container(
      padding: EdgeInsets.all(20),
      color: Theme.of(context).scaffoldBackgroundColor,
      child: Column(
        children: [
          CommonWidgets.buildTextFieldWithIcon(Icons.email_outlined, 'Email', false, true, true,controller: _emailController),
          CommonWidgets.buildTextFieldWithIcon(Icons.lock_outline, 'Password', true, false, false,controller: _passwordController,isPassword:true),
          SizedBox(height: 20),
          CommonWidgets.buildLoginButton(onPressed: loginUser),
          SizedBox(height: 20),
          // ... rest of your code
        ],
      ),
    );

  }
 }
