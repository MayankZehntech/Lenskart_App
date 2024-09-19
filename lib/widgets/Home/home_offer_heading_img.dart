import 'package:flutter/material.dart';

class HomeOfferHeadingImg extends StatelessWidget {
  final String heading;
  final String subtTitle;
  final List<String> imagePaths;
  final List<VoidCallback> onImageTaps;

  const HomeOfferHeadingImg({
    super.key,
    required this.heading,
    required this.imagePaths,
    required this.onImageTaps,
    required this.subtTitle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 15, top: 20),
          child: Text(
            heading,
            style: const TextStyle(
                fontFamily: 'poppins',
                fontSize: 18,
                fontWeight: FontWeight.w900,
                color: Color.fromARGB(255, 1, 30, 73)),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 15, bottom: 15),
          child: Text(
            subtTitle,
            style: const TextStyle(
                fontFamily: 'poppins',
                fontSize: 15,
                fontWeight: FontWeight.normal,
                color: Color.fromARGB(255, 114, 114, 114)),
          ),
        ),
        LayoutBuilder(
          builder: (context, constraints) {
            final availableWidth =
                constraints.maxWidth - 12; // Total padding (15 each side)
            final itemWidth =
                (availableWidth / 3); // Width for each image minus spacing

            return SizedBox(
              height: 140,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 6,
                ), // Padding from left and right
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: List.generate(
                    imagePaths.length,
                    (index) => SizedBox(
                      width: itemWidth, // Set width of each image
                      //height: 280,
                      child: GestureDetector(
                        onTap: onImageTaps[index],
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(
                              2), // Border radius for images
                          child: Image.asset(
                            imagePaths[index],
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
