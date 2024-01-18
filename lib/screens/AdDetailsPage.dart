import 'package:flutter/material.dart';

class AdDetailsPage extends StatelessWidget {
  final String adId;

  AdDetailsPage({required this.adId});
  @override

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ad Details'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Ad Details for ID: $adId'),
            // Add any other content or widgets as needed
          ],
        ),
      ),
    );
  }
}