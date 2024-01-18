// success_order_page.dart

import 'package:flutter/material.dart';
import 'package:untitled/home_page.dart';
import 'package:untitled/screens/orderspage.dart';

class SuccessOrderPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Container(),
        backgroundColor: Colors.grey[200],
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Stack(
              children: [
                IconButton(
                  icon: Icon(Icons.close),
                  color: Color(0xFFFF6969),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              HomePage(), // Pass the orders page
                        ));
                  },
                ),
              ],
            ),
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              backgroundColor: Colors.white,
              radius: 50,
              child: Icon(
                Icons.check,
                color: Colors.red,
                size: 50,
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Order Placed',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'Your order has been placed successfully',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          OrdersPage(),
                    ));              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Color(0xFFFF6969)),

              ),
              child: Text('My Orders',style: TextStyle(color: Colors.white),),
            ),
          ],
        ),
      ),
    );
  }
}
