import 'package:flutter/material.dart';

class LoginOfferText extends StatelessWidget {
  const LoginOfferText({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 25),
      child: RichText(
        text: const TextSpan(
          style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w600,
              fontFamily: 'poppins',
              color: Color.fromARGB(255, 0, 16, 29)),
          children: <TextSpan>[
            TextSpan(text: 'Login and avail Buy 1 Get 1 Free with'),
            TextSpan(
              text: ' GOLD',
              style: TextStyle(
                fontSize: 19,
                fontFamily: 'poppins',
                fontWeight: FontWeight.normal,
                color: Color.fromARGB(255, 223, 187, 91),
              ),
            )
          ],
        ),
      ),
    );
  }
}
