import 'package:flutter/material.dart';
// import 'package:lenskart_clone/modules/Home/ui/home_screen.dart';

class BottomNavbarButton extends StatelessWidget {
  final String buttonText;
  final VoidCallback onPress;
  const BottomNavbarButton({
    super.key,
    required this.buttonText,
    required this.onPress,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(18), topRight: Radius.circular(18)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
          ),
        ],
      ),
      child: ElevatedButton(
        onPressed: onPress,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color.fromARGB(255, 2, 27, 48), // Button color
          padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: Text(
          buttonText,
          style: const TextStyle(
              fontSize: 18,
              fontFamily: 'poppins',
              color: Colors.white,
              fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}
