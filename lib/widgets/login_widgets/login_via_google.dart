import 'package:flutter/material.dart';

class LoginViaGoogle extends StatelessWidget {
  const LoginViaGoogle({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: TextButton(
        child: const Text(
          'Login via Google >',
          style: TextStyle(
              fontFamily: 'poppins',
              fontSize: 14,
              color: Color.fromARGB(255, 33, 100, 35),
              fontWeight: FontWeight.w800),
        ),
        onPressed: () {},
      ),
    );
  }
}
