import 'package:flutter/material.dart';
import '../../widgets/common_widgets.dart';

//signup screen
class Tab1Content extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      color: Theme.of(context).scaffoldBackgroundColor,
      child: Column(
        children: [
          CommonWidgets.buildTextFieldWithIcon(Icons.email_outlined, 'Email', false, true, true),
          CommonWidgets.buildTextFieldWithIcon(Icons.person_2_outlined, 'UserName', false, false, false),
          CommonWidgets.buildTextFieldWithIcon(Icons.lock_outline, 'Password', true, false, false),
          SizedBox(height: 20),
          CommonWidgets.buildSignUpButton(),
          SizedBox(height: 20),
          // ... rest of your code
        ],
      ),
    );
  }
}
