import 'package:provider/provider.dart';

import 'Products.dart';
import 'package:flutter/material.dart';

import 'bottomnavigationwidget.dart';
import 'cartItem.dart';
import 'cart_provider.dart';
import 'cartpage.dart';

class ProductDetailsPage extends StatefulWidget {
  final Products product;

  ProductDetailsPage({required this.product});

  @override
  _ProductDetailsPageState createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  int _currentPage = 0;
  int _currentIndex = 4;
  String selectedColor = '';
  String selectedSize = '';
  bool isDataLoaded = false;
  final Cart cart = Cart(); // Create an instance of the Cart class

  @override
  void initState() {
    super.initState();
    loadData();
  }

  void addToCart() {
    if (selectedColor.isNotEmpty && selectedSize.isNotEmpty) {
      CartItem item = CartItem(
        name: widget.product.name,
        description: widget.product.description,
        price: widget.product.price,
        color: selectedColor,
        size: selectedSize,
        image: widget.product.image,
        quantity: 1,
      );
      Provider.of<CartProvider>(context, listen: false).addToCart(item);
      Navigator.push(
          context,
          MaterialPageRoute(
          builder: (context) => CartPage(), // Pass the cart instance to the CartPage
    ));
/*
      // Add the selected item to the cart
      cart.addToCart(item);

      // Navigate to the cart page (you need to implement the CartPage)

      );*/

    } else {
      // Show a message to the user that they need to select color and size
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please select color and size before adding to cart.'),
        ),
      );
    }
  }
  Future<void> loadData() async {
    // Simulate asynchronous loading of data from Firestore
    // Replace this with your actual asynchronous data loading logic
    await Future.delayed(Duration(seconds: 2));

    setState(() {
      isDataLoaded = true;
    });
  }
  @override

  Widget build(BuildContext context) {
    CartProvider cartProvider = Provider.of<CartProvider>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(90.0),
        child: AppBar(
          toolbarHeight: 100,
          backgroundColor: Colors.white,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 1.0),
                      child: Text(
                        widget.product.description,
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Color(0xFF515C6F)),
                      ),
                    ),
                    SizedBox(height: 2.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          widget.product.price,
                          style: TextStyle(
                            fontSize: 18.0,
                            color: Color(0xFF515C6F),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(width: 10.0),
                        Container(
                          width: 50,
                          height: 20,
                          padding: EdgeInsets.symmetric(horizontal: 4.0),
                          decoration: BoxDecoration(
                            color: Color(0xFFFF6969),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.star,
                                color: Colors.white,
                                size: 14,
                              ),
                              SizedBox(width: 4.0),
                              Text(
                                '4.5', // Replace with the actual review value
                                style: TextStyle(
                                    color: Colors.white, fontSize: 14),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Stack(
                children: [
                  IconButton(
                    icon: Icon(
                      Icons.shopping_cart_outlined,
                      size: 32,
                      color: Color(0xFF8E95A2),
                    ),
                    onPressed: () {
                      // Handle cart icon press
                    },
                  ),
                  Positioned(
                    left: 0,
                    bottom: 0,
                    child: Container(
                      padding: EdgeInsets.all(4.0),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(0xFFFF6969),
                      ),
                      child: Text(
                        cartProvider.items.length.toString() ,
                        style: TextStyle(
                          color: Colors.white,
                          //fontWeight: FontWeight.bold,
                          fontSize: 12.0, // Adjust notification count size
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.white, Color(0XFFF5F6F8)], // Adjust gradient colors
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 1),
              // PageView with Image Indicator
              Container(
                height: MediaQuery.of(context).size.height / 4,
                child: Stack(
                  children: [
                    PageView.builder(
                      itemCount: widget.product.images.length,
                      onPageChanged: (index) {
                        setState(() {
                          _currentPage = index;
                        });
                      },
                      itemBuilder: (context, index) {
                        return Image.network(
                          widget.product.images[index],
                          width: 100,
                          height: 100,
                          fit: BoxFit.contain,
                        );
                      },
                    ),
                    Positioned(
                      top: 0,
                      left: 0,
                      right: 0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                          widget.product.images.length,
                          (index) => buildIndicator(index),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TabButton(text: 'Product'),
                  TabButton(text: 'Details'),
                  TabButton(text: 'Review'),
                ],
              ),
              SizedBox(height: 16),
              Text(
                'SELECT COLOR',
                style: TextStyle(fontSize: 14, color: Color(0xFFFA4ABB7)),
              ),
              SizedBox(height: 1),
              isDataLoaded
                  ? Row(
                //mainAxisAlignment: MainAxisAlignment.center,
                children: widget.product.color.map((colorCode) {
                  return ColorButton(
                    colorCode: colorCode,
                    onPressed: () {
                      print('Color selected: $colorCode');

                      setState(() {
                        selectedColor = colorCode;
                      });
                    },
                    selected: selectedColor == colorCode, // Check if the color is selected

                  );
                }).toList(),
              ):CircularProgressIndicator(),

              SizedBox(height: 2),
              Text(
                'SELECT SIZE (US)',
                style: TextStyle(fontSize: 14, color: Color(0xFFFA4ABB7)),
              ),
              SizedBox(height: 2),
              isDataLoaded
                  ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: widget.product.size.map((size) {
                  return SizeButton(
                    size: size,
                    onPressed: () {
                      setState(() {
                        selectedSize = size;
                      });
                    },
                    selected: selectedSize == size, // Check if the color is selected

                  );                }).toList(),
              ):CircularProgressIndicator(),
              SizedBox(height: 2),
              Row(

                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        // Handle share item
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white, // Background color for the button
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'SHARE THIS ',
                            style: TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.bold, // Text color for the button
                            ),
                          ),
                          Spacer(),
                          Container(
                            width:30,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.grey, // Background color for the icon circle
                            ),
                            padding: EdgeInsets.all(8), // Adjust the padding as needed
                            child: Icon(
                              Icons.arrow_upward,
                              color: Colors.white, // Color for the arrow icon
                              size: 18, // Adjust the size of the icon
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(width: 10), // Small space between buttons
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        addToCart();
                        // Handle add to cart
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFFFF6969), // Background color for the button
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'ADD TO CART',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold, // Text color for the button
                            ),
                          ),
                          Spacer(),
                          Container(
                            width: 25,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white, // Background color for the icon circle
                            ),
                            padding: EdgeInsets.all(8), // Adjust the padding as needed
                            child: Icon(
                              Icons.arrow_forward,
                              color: Color(0xFFFF6969), // Color for the arrow icon
                              size: 18, // Adjust the size of the icon
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              )


            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationWidget(
        currentIndex: _currentIndex,
      ),
    );
  }

  Widget buildIndicator(int index) {
    return Container(
      width: 8.0,
      height: 5.0,
      margin: EdgeInsets.symmetric(horizontal: 4.0),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: _currentPage == index ? Colors.blue : Colors.grey,
      ),
    );
  }
}

class TabButton extends StatelessWidget {
  final String text;

  TabButton({required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
        onPressed: () {
          // Handle tab button press
        },
        child: Text(text),
      ),
    );
  }
}

class ColorButton extends StatelessWidget {
  final String colorCode;
  final VoidCallback  onPressed;
  final bool selected;

  ColorButton({required this.colorCode, required this.onPressed, required this.selected});

  @override
  Widget build(BuildContext context) {
    Color color =
        Color(int.parse(colorCode.substring(1), radix: 16) | 0xFF000000)
            .withOpacity(0.5);

    return GestureDetector(
      onTap: onPressed,
      child: Stack(
        children: [
          Container(
            margin: EdgeInsets.all(8),
            width: 30,
            height: 30,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: color,
            ),
          ),
          if (selected)
            Positioned.fill(
              child: Align(
                alignment: Alignment.center,
                child: Icon(
                  Icons.check,
                  color: Colors.white,
                  size: 18.0,
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class SizeButton extends StatelessWidget {
  final String size;
  final VoidCallback onPressed;
  final bool selected;

  SizeButton({required this.size, required this.onPressed, required this.selected});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Stack(
        children: [
          Container(
            margin: EdgeInsets.all(8),
            padding: EdgeInsets.all(8),

            decoration: BoxDecoration(
              color: Colors.white,
                       ),
            child: Text(size,style: TextStyle(color:selected ? Color(0xFFFF6969) : Colors.grey ),),

          ),

        ],
      ),
    );
  }
}
