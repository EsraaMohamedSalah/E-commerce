// cart_page.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../screens/orderplaced.dart';
import 'CustomAppBar.dart';
import 'bottomnavigationwidget.dart';
import 'cartItem.dart';
import 'cart_provider.dart';
import 'notification_provider.dart';
import 'notificationpage.dart';
import 'orderItem.dart';

class CartPage extends StatefulWidget {
  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
 // final Cart cart;
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
                    itemCount: cartProvider.items.length,
                    itemBuilder: (context, index) {
                      CartItem item = cartProvider.items[index];
                      return buildCartItem(context,item);
                    },
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(16),
                  color: Colors.white,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [

                      Consumer<CartProvider>(
                        builder: (context, cartProvider, child) {
                          double total = cartProvider.recalculateTotal();

                          return Text(
                            'Total: \$${total.toStringAsFixed(2)}',
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          );
                        }
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          CartProvider cartProvider = Provider.of<CartProvider>(context, listen: false);
                          NotificationProvider notificationProvider = Provider.of<NotificationProvider>(context, listen: false);

                          // Convert cart items to order items
                          List<OrderItem> orderItems = cartProvider.convertToOrderItems();

                          // Save the order to Firestore
                          await cartProvider.saveOrderToFirestore(orderItems);

                          // Clear the cart and update the notification count
                          cartProvider.clearCart();
                          notificationProvider.loadNotificationData(context);
                          Navigator.push(context , MaterialPageRoute(
                            builder: (context) => SuccessOrderPage(), // Pass the orders page
                              ));
                          // Navigate to the next screen or perform other actions
                        },
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(Color(0xFFFF6969)),

                        ),
                        child: Text('Proceed to Checkout',style: TextStyle(color: Colors.white),),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        }
      ),
      bottomNavigationBar: BottomNavigationWidget(currentIndex: 2,), // Assuming you have a BottomNavigationWidget
    );
  }

  Widget buildCartItem(BuildContext context,CartItem item) {
    return Card(
      margin: EdgeInsets.all(8),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: NetworkImage(item.image),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(width: 16),
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
                    Row(
                      children: [
                        Container(
                          width: 20,
                          height: 20,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: parseColor(item.color),
                          ),
                        ),
                        SizedBox(width: 8),
                        Text(
                          ' Size: ${item.size}',
                          style: TextStyle(fontSize: 14),
                        ),
                      ],
                    ),
                    Text(
                      'Price: \$${item.price}',
                      style: TextStyle(fontSize: 14),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        setState(() {
                          Provider.of<CartProvider>(context, listen: false).decreaseQuantity(item);
                        });
                      },
                      icon: Icon(Icons.remove),
                    ),
                    Text(item.quantity.toString()), // Implement dynamic quantity here
                    IconButton(
                      onPressed: () {
                       setState(() {
                        Provider.of<CartProvider>(context, listen: false).increaseQuantity(item);
                       });

                      },
                      icon: Icon(Icons.add),
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

  Color parseColor(String colorCode) {
    return Color(int.parse(colorCode.substring(1), radix: 16) | 0xFF000000).withOpacity(0.5);

  }

  String calculateTotal(BuildContext context) {
    double total = 0;
    for (CartItem item in Provider.of<CartProvider>(context).items) {
      // Remove '$' sign before converting to double
      String priceWithoutSymbol = item.price.replaceAll('\$', '');
      total += double.parse(priceWithoutSymbol);
    }
    return total.toStringAsFixed(2);
  }

}
