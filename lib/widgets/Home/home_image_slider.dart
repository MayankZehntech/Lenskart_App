import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class ImageSlider extends StatelessWidget {
  final List<String> imagePath;

  const ImageSlider({
    super.key,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        autoPlay: true,
        enlargeCenterPage: true,
        enableInfiniteScroll: true,
        viewportFraction: 1,
        aspectRatio: 2,
        onPageChanged: (index, reason) {
          //handle any logic when the page changes if needed
        },
      ),
      items: imagePath.map((imagePath) {
        return Builder(
          builder: (BuildContext context) {
            return Container(
              //margin: const EdgeInsets.symmetric(horizontal: 0.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                image: DecorationImage(
                  image: AssetImage(imagePath),
                  fit: BoxFit.cover,
                ),
              ),
            );
          },
        );
      }).toList(),
    );
  }
}
