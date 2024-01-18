
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled/screens/orderspage.dart';

import '../auth_service.dart';
import '../newlogin.dart';
import '../widgets/CustomAppBar.dart';
import '../widgets/bottomnavigationwidget.dart';
import '../widgets/cart_provider.dart';
import '../widgets/cartpage.dart';
import '../widgets/notification_provider.dart';
import '../widgets/notificationpage.dart';

class ProfilePage extends StatelessWidget {
  final String username; // Replace with the username from Firestore
  final String email;    // Replace with the email from Firestore
  final String photoUrl; // Replace with the URL for the user's profile photo

  ProfilePage({required this.username, required this.email, required this.photoUrl});
  int _currentIndex = 3;
  final AuthService authService = AuthService();

  @override
  Widget build(BuildContext context) {
    CartProvider cartProvider = Provider.of<CartProvider>(context);
    NotificationProvider notificationProvider = Provider.of<NotificationProvider>(context);

    int cartItemCount = cartProvider.items.length;
    Color backgroundColor = Color(0x0F727C8E);
    int notificationCount = notificationProvider.items.length;
    return Scaffold(

      appBar: CustomAppBar(
          backgroundColor: backgroundColor,
          notificationCount: notificationCount,
          cartItemCount: cartItemCount,
          onCartPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CartPage(), // Pass the cart instance to the CartPage
                ));
          },
          onNotificationPressed:(){
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => NotificationPage(), // Pass the cart instance to the CartPage
                ));
          }
      ),
      body: Container(
        color: Color(0x0F727C8E), // Set the background color of the page
        padding: const EdgeInsets.all(16.0),
        child: Column(

          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(

              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: CircleAvatar(
                    radius: 50.0,
                    backgroundImage: NetworkImage(photoUrl), // Use the user's photo URL
                  ),
                ),
                SizedBox(width: 20.0),

                Column(
                  children: [
                    Text(
                      username,
                      style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold,color: Color(0XFF515C6F)),
                    ),
                    SizedBox(height: 3.0),

                    Text(
                      email,
                      style: TextStyle(fontSize: 16.0,color: Color(0XFF515C6F)),
                    ),
                  ],
                ),

              ],
            ),

            SizedBox(height: 20.0),
            Container(
              color: Colors.white,
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildListItem('View Past Orders', Icons.reorder,Icons.arrow_circle_right,context),
                  SizedBox(height: 10.0),
                  Divider(),
                  SizedBox(height: 10.0),

                  buildListItem('Logout', Icons.logout,Icons.arrow_circle_right,context),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationWidget(
        currentIndex: _currentIndex,
      ),
    );
  }
  Widget buildListItem(String text, IconData icon, IconData iconRight,BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click, // Change cursor on hover
      child: GestureDetector(
        onTap: () {
          if (text == 'Logout') {
            // Handle logout
            _handleLogout(context);
          } else if(text=='View Past Orders'){
            Navigator.push(
                context,
                MaterialPageRoute(
                builder: (context) => OrdersPage(),
          ));
            // Handle other list item taps
            // Add your logic here
          }
        },
        child: Row(
          children: [
            Icon(icon, color: Color(0xFF727C8E)),
            SizedBox(width: 10.0),
            Expanded(
              child: Text(
                text,
                style: TextStyle(color: Color(0XFF515C6F)),
              ),
            ),
            Icon(iconRight, color: Color(0xFF727C8E)),
          ],
        ),
      ),
    );
  }

  void _handleLogout(BuildContext context) async {
    await authService.logout();
    Navigator.push(
      context ,
      MaterialPageRoute(
        builder: (context) => MyHomePage(),
      ),
    );
  }
}
