import 'Products.dart';
import 'package:flutter/material.dart';

class ProductDetailsPage extends StatefulWidget {
  final Products product;

  ProductDetailsPage({required this.product});

  @override
  _ProductDetailsPageState createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
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
                        '1',
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
                        return Image.asset(
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
              Row(
                //mainAxisAlignment: MainAxisAlignment.center,
                children: widget.product.color.map((colorCode) {
                  return ColorButton(colorCode: colorCode);
                }).toList(),
              ),

              SizedBox(height: 2),
              Text(
                'SELECT SIZE (US)',
                style: TextStyle(fontSize: 14, color: Color(0xFFFA4ABB7)),
              ),
              SizedBox(height: 2),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: widget.product.size.map((size) {
                  return SizeButton(size: size);
                }).toList(),
              ),
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

  ColorButton({required this.colorCode});

  @override
  Widget build(BuildContext context) {
    Color color =
        Color(int.parse(colorCode.substring(1), radix: 16) | 0xFF000000)
            .withOpacity(0.5);

    return Container(
      margin: EdgeInsets.all(8),
      width: 30,
      height: 30,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
      ),
    );
  }
}

class SizeButton extends StatelessWidget {
  final String size;

  SizeButton({required this.size});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(8),
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(size),
    );
  }
}
