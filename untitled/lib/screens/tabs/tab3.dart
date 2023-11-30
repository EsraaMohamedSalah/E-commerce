import 'package:flutter/material.dart';
import '../../widgets/common_widgets.dart';

class Tab3Content extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      color: Theme.of(context).scaffoldBackgroundColor,
      child: Column(
        children: [
          RichText(
            text: TextSpan(
              text: 'Enter the email address you used to create your account and we will email you a link to reset your password',
              style: TextStyle(
                color:  Color(0xFF515C6F),
              ),

            ),
          ),

          SizedBox(height: 20),

          CommonWidgets.buildTextFieldWithIcon(Icons.email_outlined, 'Email', false,true,true),
          CommonWidgets.buildForgotPassButton(),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}
