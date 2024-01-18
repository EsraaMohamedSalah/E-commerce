import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Color backgroundColor;
  final int cartItemCount;
  final int notificationCount;
  final Function() onCartPressed;
  final Function() onNotificationPressed;

  CustomAppBar({
    required this.backgroundColor,
    required this.cartItemCount,
    required this.notificationCount,
    required this.onCartPressed,
    required this.onNotificationPressed,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: Container(),
      backgroundColor: backgroundColor,
      actions: [
        Stack(
          children: [
            IconButton(
              icon: Icon(
                Icons.shopping_cart_outlined,
                size: 20,
                color: Color(0xFF8E95A2),
              ),
              onPressed: onCartPressed,
            ),
            Positioned(
              left: 20,
              bottom: 5,
              child: Container(
                padding: EdgeInsets.all(4.0),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xFFFF6969),
                ),
                child: Text(
                  cartItemCount.toString(),
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12.0,
                  ),
                ),
              ),
            ),
          ],
        ),
        Stack(
          children: [
            IconButton(
              icon: Icon(Icons.notifications_none_sharp),
              color: Color(0xFF8E95A2),
              onPressed: onNotificationPressed,
            ),
            Positioned(
              left: 20,
              bottom: 5,
              child: Container(
                padding: EdgeInsets.all(4.0),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xFFFF6969),
                ),
                child: Text(
                  notificationCount.toString(),
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12.0,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
