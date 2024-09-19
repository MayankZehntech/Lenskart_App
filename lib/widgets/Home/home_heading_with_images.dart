import 'package:flutter/material.dart';

class HeadingWithImages extends StatelessWidget {
  final String heading;
  final List<String> imagePaths;
  final List<VoidCallback> onImageTaps;

  const HeadingWithImages({
    super.key,
    required this.heading,
    required this.imagePaths,
    required this.onImageTaps,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 15, bottom: 15, top: 20),
          child: Text(
            heading,
            style: const TextStyle(
                fontFamily: 'poppins',
                fontSize: 18,
                fontWeight: FontWeight.w900,
                color: Color.fromARGB(255, 1, 30, 73)),
          ),
        ),
        LayoutBuilder(
          builder: (context, constraints) {
            final availableWidth =
                constraints.maxWidth - 30; // Total padding (15 each side)
            final itemWidth =
                (availableWidth / 4); // Width for each image minus spacing

            return SizedBox(
              height: 120,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 15), // Padding from left and right
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
