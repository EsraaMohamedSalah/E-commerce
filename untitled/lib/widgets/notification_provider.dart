import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'NotificationItem.dart';

class NotificationProvider extends ChangeNotifier {
  List<NotificationItem> _items = [];

  List<NotificationItem> get items => _items;

  Future<void> loadNotificationData(BuildContext context) async {
    try {
      QuerySnapshot<Map<String, dynamic>> snapshot =
      await FirebaseFirestore.instance.collection('notification').get();

      _items = snapshot.docs.map((doc) => NotificationItem.fromFirestore(doc)).toList();
      notifyListeners();
    } catch (error) {
      print('Error loading product data: $error');
    }
  }


}


