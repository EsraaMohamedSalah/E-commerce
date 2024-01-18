// AllCategoriesPage.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled/widgets/Categories.dart';
import 'package:untitled/widgets/Products.dart';

import '../app_data_provider.dart';
import '../home_page.dart';
import '../widgets/bottomnavigationwidget.dart';

class AllCategoriesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Fetch all categories and products from the provider
    List<Categories> categories = context.read<AppDataProvider>().categories;
    List<Products> products = context.read<AppDataProvider>().products;

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
      body: Column(
        children: [
          Row(
           crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Container(child: Text("All Categories",style: TextStyle(fontSize: 30,color: Color(0xFF727C8E)),)),
              ),

            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Column for Categories
              Expanded(
                flex: 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Display all categories in a column
                    for (Categories category in categories) ...[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
                          onTap: () {
                            // Handle category click
                            // You can navigate to a specific category page or perform any other action
                          },
                          child: category.buildCategoryWidget(context),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              // Divider between columns
              VerticalDivider(width: 1, color: Colors.grey),
              // Column for Products
              Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    color: Colors.white,
                    padding: EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [

                        SizedBox(height: 10),
                        // Display products in a list
                        for (Products product in products) ...[
                          ListTile(
                            title: Text(product.name ?? ''),
                            // Add other details as needed
                          ),
                          Divider(), // Divider between products
                        ],
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationWidget(
        currentIndex: 4,
      ),
    );
  }
}
