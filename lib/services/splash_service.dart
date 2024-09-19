import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lenskart_clone/modules/Home/ui/home_screen.dart';
import 'package:lenskart_clone/modules/Login/ui/login_screen.dart';

class SplashServices {
  // check user is logged in or not
  isUserLogin(BuildContext context) {
    final auth = FirebaseAuth.instance;
    final user = auth.currentUser;

    if (user != null) {
      Timer(const Duration(seconds: 1), () {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const HomeScreen(),
            ));
      });
    } else {
      Timer(
        const Duration(seconds: 2),
        () {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const LoginScreen(),
              ));
        },
      );
    }
  }
}
