import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class NotificationItem extends ChangeNotifier {
  final String name;
  final String description;

  NotificationItem({
    required this.name,
    required this.description,
  });

  factory NotificationItem.fromFirestore(QueryDocumentSnapshot<Map<String, dynamic>> snapshot) {
    Map<String, dynamic> json = snapshot.data() ?? {};
    return NotificationItem.fromJson(json);
  }

  factory NotificationItem.fromJson(Map<String, dynamic> json) {
    return NotificationItem(
      description: json['description'] ?? '',
      name: json['name'] ?? '',
    );
  }
}
