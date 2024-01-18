import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';

class CarouselSliderWidget<T> extends StatefulWidget {
  final List<T> items;
  final Widget Function(T item) itemBuilder;

  CarouselSliderWidget({required this.items, required this.itemBuilder});

  @override
  _CarouselSliderWidgetState createState() => _CarouselSliderWidgetState<T>();
}

class _CarouselSliderWidgetState<T> extends State<CarouselSliderWidget<T>> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider(
          items: widget.items.map((item) => widget.itemBuilder(item)).toList(),
          options: CarouselOptions(
            height: 200.0,
            autoPlay: true,
            autoPlayInterval: Duration(seconds: 2), // Adjust this value
            autoPlayAnimationDuration: Duration(milliseconds: 800), // Adjust this value

            onPageChanged: (index, reason) {
              setState(() {
                _currentIndex = index;
              });
            },
          ),
        ),
        SizedBox(height: 10),
        DotsIndicator(
          dotsCount: widget.items.length,
          position: _currentIndex.toDouble(),
          decorator: DotsDecorator(
            color: Colors.grey,
            activeColor: Colors.blue, 
          ),
        ),
      ],
    );
  }
}
