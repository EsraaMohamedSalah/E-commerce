// orders_page.dart

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';

import '../widgets/CustomAppBar.dart';
import '../widgets/bottomnavigationwidget.dart';
import '../widgets/cart_provider.dart';
import '../widgets/cartpage.dart';
import '../widgets/notification_provider.dart';
import '../widgets/notificationpage.dart';

class OrdersPage extends StatefulWidget {
  @override
  _OrdersPageState createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {
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
      body: FutureBuilder(
        future: _getOrders(),
        builder: (context, AsyncSnapshot<List<DocumentSnapshot>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(
              child: Text('No orders available'),
            );
          } else {
            List<DocumentSnapshot> sortedOrders = snapshot.data!
              ..sort((a, b) {
                Timestamp timestampA = (a.data() as Map<String, dynamic>)['timestamp'];
                Timestamp timestampB = (b.data() as Map<String, dynamic>)['timestamp'];
                return timestampB.compareTo(timestampA);
              });
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return _buildOrderItem(snapshot.data![index]);
              },
            );
          }
        },
      ),
      bottomNavigationBar: BottomNavigationWidget(
        currentIndex: 4,
      ),
    );
  }

  Widget _buildOrderItem(DocumentSnapshot orderSnapshot) {
    Map<String, dynamic> orderData = orderSnapshot.data() as Map<String, dynamic>;
    Timestamp timestamp = orderData['timestamp'] as Timestamp;

    User? user = FirebaseAuth.instance.currentUser;
    String? orderUserId = orderData['userId'];
    if (user?.uid != orderUserId) {
      return SizedBox.shrink(); // Skip orders from other users
    }
    return ListTile(
      tileColor: Colors.white,
      leading: Icon(Icons.open_in_new_rounded), // Set icon
      title: Text(
        'Order #${orderSnapshot.id}',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      subtitle: Text('Order placed on ${_formatTimestamp(timestamp)}',
      ),
      onTap:() async {
        Map<String, dynamic> orderDetails = await Provider.of<CartProvider>(context, listen: false).getOrderDetails(orderSnapshot.id);

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => OrderDetailsPage(orderData,orderDetails),
          ),
        );
      },
    );
  }

  Future<List<DocumentSnapshot>> _getOrders() async {
    QuerySnapshot ordersSnapshot = await FirebaseFirestore.instance.collection('orders').get();
    return ordersSnapshot.docs;
  }
}
String _formatTimestamp(Timestamp timestamp) {
  DateTime dateTime = timestamp.toDate();
  return '${dateTime.day}/${dateTime.month}/${dateTime.year} ${dateTime.hour}:${dateTime.minute}';
}
class OrderDetailsPage extends StatelessWidget {
  final Map<String, dynamic> orderData;
  final Map<String, dynamic> orderDetails;

  OrderDetailsPage(this.orderData, this.orderDetails);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Order #${orderDetails['orderId']}'),
      ),
      body: ListView.builder(
        itemCount: orderData['items'].length,
        itemBuilder: (context, index) {
          Map<String, dynamic> itemData = orderData['items'][index];

          return ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(itemData['image']),
            ),
            title: Text(itemData['name']),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(itemData['description']),
                SizedBox(height: 8),
                Row(
                  children: [
                    Text('color : '),

                    Container(
                      width: 20,
                      height: 20,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: parseColor(itemData['color']),
                      ),
                    ),
                    SizedBox(width: 8),
                    Text('Size: ${itemData['size']}'),
                  ],
                ),
              ],
            ),
          );
        },
      ),
      bottomNavigationBar: BottomNavigationWidget(
        currentIndex: 4,
      ),
    );
  }

  Color parseColor(String colorCode) {
    return Color(int.parse(colorCode.substring(1), radix: 16) | 0xFF000000).withOpacity(0.5);
  }
}
