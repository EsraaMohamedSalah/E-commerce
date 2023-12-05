import 'package:flutter/material.dart';

class CommonWidgets {

  static Widget buildTextFieldWithIcon(IconData icon, String title, bool hasBottomBorder,bool hasupRadius,bool hasspacing ,{
  TextEditingController? controller,
  bool isPassword = false, // Add this parameter
  }) {
    return Container(
      width: 800,
      margin: EdgeInsets.only(bottom: hasspacing ? 1 : 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        color: Colors.white,
      ),
      child:  TextFormField(
        controller: controller,
        obscureText: isPassword, // Set obscureText to true for password

        validator: (value) {
          if (value == null || value.isEmpty) {
            return '$title is required';
          }
          return null;
        },
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

  static Widget buildSignUpButton() {
    return Container(
      width: 400,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Color(0xFFFF6969), // Change the color as needed
      ),
      child: TextButton(
        onPressed: () {

          // Add your signup logic here
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center
          ,
          children: [
            Expanded(
              child: Center(
                child: Text(
                  'Sign Up',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),

            SizedBox(width: 5),
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
 static buildForgotPassButton() {
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
         mainAxisAlignment: MainAxisAlignment.center
         ,
         children: [
           Expanded(
             child: Center(
               child: Text(
                 'Send Mail',
                 style: TextStyle(color: Colors.white),
               ),
             ),
           ),

           SizedBox(width: 5),
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


  static Widget buildLoginButton({
    required VoidCallback onPressed,
  }) {
    return Container(
      width: 800,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Color(0xFFFF6969),
      ),
      child: TextButton(
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Center(
                child: Text(
                  'Log In',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(1),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
              ),
              child: Icon(
                Icons.arrow_forward_ios,
                size: 20,
                color: Color(0xFFFF6969),
              ),
            ),
          ],
        ),
      ),
    );
  }


static Widget buildSeeMoreButton(){
    return
      Row(
        children: [
          Container(
            width: 120, // Set your preferred width
            child: ElevatedButton(
              onPressed: () {
                // Handle "See more" button press
              },
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 16), // Adjust padding as needed
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('See more'),
                  Container(
                    width: 18, // Set your preferred size for the red background
                    height: 18,
                    //padding: EdgeInsets.all(4),
                    padding: EdgeInsets.all(0.5),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xFFFF6969), // Set the background color to red
                    ),
                    child: Icon(
                      Icons.arrow_forward_ios,
                      size: 14,

                      color: Colors.white, // Change the color as needed
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],

      );

}
}
