import 'package:flutter/material.dart';

class ExclusivlyLenskartGridWithHeading extends StatelessWidget {
  final String heading;
  final String subheading;
  final List<String> imagePaths;
  final List<VoidCallback> onImageTaps;

  const ExclusivlyLenskartGridWithHeading({
    super.key,
    required this.heading,
    required this.subheading,
    required this.imagePaths,
    required this.onImageTaps,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 15, top: 10, bottom: 5),
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
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Text(
            subheading,
            style: const TextStyle(
                fontFamily: 'poppins',
                fontSize: 15,
                fontWeight: FontWeight.normal,
                color: Color.fromARGB(255, 114, 114, 114)),
          ),
        ),
        //const SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.only(left: 15, right: 15, bottom: 15),
          child: GridView.builder(
            physics:
                const NeverScrollableScrollPhysics(), // Prevents scrolling inside the grid
            shrinkWrap: true, // Ensures the grid takes only necessary height
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, // 2 images per row
              crossAxisSpacing: 10, // Horizontal space between images
              mainAxisSpacing: 10, // Vertical space between images
              childAspectRatio: 1, // Adjust the aspect ratio of the grid cells
            ),
            itemCount: imagePaths.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: onImageTaps[index],
                child: ClipRRect(
                  borderRadius:
                      BorderRadius.circular(18), // Border radius for images
                  child: Image.asset(
                    imagePaths[index],
                    fit: BoxFit.cover,
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
