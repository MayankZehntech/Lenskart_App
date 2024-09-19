import 'package:flutter/material.dart';

class LoginpageTermsCondition extends StatelessWidget {
  const LoginpageTermsCondition({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: RichText(
          text: const TextSpan(
              style: TextStyle(
                  fontFamily: 'poppins',
                  fontSize: 10,
                  color: Color.fromARGB(255, 0, 5, 77)),
              children: [
            TextSpan(text: 'By signing in you agree to our '),
            TextSpan(
              text: 'Terms of service ',
              style: TextStyle(
                  fontFamily: 'poppins',
                  color: Colors.cyan,
                  decoration: TextDecoration.underline),
            ),
            TextSpan(text: '& '),
            TextSpan(
                text: 'Privacy Policy.',
                style: TextStyle(
                    fontFamily: 'poppins',
                    color: Colors.cyan,
                    decoration: TextDecoration.underline))
          ])),
    );
  }
}
