// cart_page.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled/widgets/NotificationItem.dart';
import 'package:untitled/widgets/notification_provider.dart';
import 'package:untitled/widgets/notification_provider.dart';
import 'CustomAppBar.dart';
import 'bottomnavigationwidget.dart';
import 'cartItem.dart';
import 'cart_provider.dart';
import 'cartpage.dart';
import 'notification_provider.dart';
import 'notification_provider.dart';

class NotificationPage extends StatefulWidget {
  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {

  void initState() {
    super.initState();
    // Load and decode the JSON file
    final notificationProvider = Provider.of<NotificationProvider>(context, listen: false);
    notificationProvider.loadNotificationData(context);
  }
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

      body: Builder(
          builder: (context) {
            return Container(
              color: Colors.grey[200], // Adjust the background color as needed
              child: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: notificationProvider.items.length,
                      itemBuilder: (context, index) {
                        NotificationItem item = notificationProvider.items[index];
                        return buildNotificationItem(context,item);
                      },
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(16),
                    color: Colors.white,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [

                      ],
                    ),
                  ),
                ],
              ),
            );
          }
      ),
      bottomNavigationBar: BottomNavigationWidget(currentIndex: 4,), // Assuming you have a BottomNavigationWidget
    );
  }

  Widget buildNotificationItem(BuildContext context,NotificationItem item) {
    return Card(
      margin: EdgeInsets.all(8),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.name,
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      item.description,
                      style: TextStyle(fontSize: 14),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }


}
