import 'package:flutter/material.dart';

class SunSeasonHeadingAndSlider extends StatelessWidget {
  final String heading;
  final List<String> imagePaths;
  final IconData icon;
  final double imageWidth;
  final double imageHeight;

  SunSeasonHeadingAndSlider({
    super.key,
    required this.heading,
    required this.imagePaths,
    this.icon = Icons.wb_sunny, // Default sun icon
    this.imageWidth = 150,
    this.imageHeight = 170,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
          child: Row(
            children: [
              Text(
                heading,
                style: const TextStyle(
                    fontFamily: 'poppins',
                    fontSize: 18,
                    fontWeight: FontWeight.w900,
                    color: Color.fromARGB(255, 1, 30, 73)),
              ),
              const SizedBox(width: 8), // Spacing between heading and icon
              Icon(icon, color: Colors.orange, size: 24),
            ],
          ),
        ),
        const SizedBox(height: 5),
        Padding(
          padding: const EdgeInsets.only(left: 15, right: 15),
          child: SizedBox(
            height: imageHeight, // Adjust the height as needed
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: imagePaths.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    // Add your onTap action here for each image
                  },
                  child: Container(
                    width: imageWidth, // Adjust width to control size
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(18),
                      image: DecorationImage(
                        image: AssetImage(imagePaths[index]),
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
