import 'package:cloud_firestore/cloud_firestore.dart';

class Ad {
  final String image;
  final String link;
  final String description;

  Ad({
    required this.image,
    required this.link,
    required this.description
  });

  factory Ad.fromJson(Map<String, dynamic> json) {
    return Ad(
      image: json['image'] ?? '',
      link: json['link'] ?? '',
      description: json['description']??'',
    );
  }
  factory Ad.fromFirestore(DocumentSnapshot<Map<String, dynamic>> snapshot) {
    Map<String, dynamic> json = snapshot.data() ?? {};
    return Ad.fromJson(json);
  }
}