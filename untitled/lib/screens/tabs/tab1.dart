import 'package:flutter/material.dart';
import '../../widgets/common_widgets.dart';

//signup screen
class Tab1Content extends StatelessWidget {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      color: Theme.of(context).scaffoldBackgroundColor,
      child: Column(
        children: [
          CommonWidgets.buildTextFieldWithIcon(Icons.email_outlined, 'Email', false, true, true,controller: emailController,),
          CommonWidgets.buildTextFieldWithIcon(Icons.person_2_outlined, 'UserName', false, false, false),
          CommonWidgets.buildTextFieldWithIcon(Icons.lock_outline, 'Password', true, false, false,controller: passwordController,isPassword: true),
          SizedBox(height: 20),
          CommonWidgets.buildSignUpButton(
            context: context,
            emailController: emailController,
            passwordController: passwordController,
          ),
          SizedBox(height: 1),
        ],
      ),
    );
  }
}
