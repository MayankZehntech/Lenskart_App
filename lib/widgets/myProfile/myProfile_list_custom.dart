import 'package:flutter/material.dart';

class CustomSection extends StatelessWidget {
  final String heading;
  final List<String> tileTitles;
  final List<String> tileImages;
  final VoidCallback onTap;

  const CustomSection({
    Key? key,
    required this.heading,
    required this.tileTitles,
    required this.tileImages,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 255, 255, 255),
        border: Border.all(
          color: const Color.fromARGB(255, 236, 236, 236),
        ),
        borderRadius: const BorderRadius.all(Radius.circular(12)),
      ),
      child: Column(
        children: [
          // Heading
          Container(
            padding: const EdgeInsets.all(12),
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
              border: BorderDirectional(
                bottom: BorderSide(
                  color: Color.fromARGB(255, 236, 236, 236),
                ),
              ),
            ),
            child: Text(
              heading,
              style: const TextStyle(
                fontFamily: 'poppins',
                fontSize: 17,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 1, 30, 73),
              ),
            ),
          ),
          // List tiles
          Column(
            children: List.generate(tileTitles.length, (index) {
              return InkWell(
                onTap: onTap,
                child: Column(
                  children: [
                    SizedBox(
                      height: 40, // Adjust the height for the list tile
                      child: ListTile(
                        dense: true,
                        contentPadding:
                            const EdgeInsets.symmetric(horizontal: 12),
                        leading: Image.asset(
                          tileImages[index],
                          width: 40,
                        ),
                        title: Text(
                          tileTitles[index],
                          style: const TextStyle(
                            fontFamily: 'poppins',
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                            color: Color.fromARGB(255, 1, 30, 73),
                          ),
                        ),
                        trailing: Image.asset(
                          'assets/images/Arrow.webp',
                          width: 40,
                        ),
                      ),
                    ),
                    if (index < tileTitles.length - 1)
                      // Show divider except after the last item
                      const Divider(
                        color: Color.fromARGB(255, 236, 236, 236),
                      ),
                  ],
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}
