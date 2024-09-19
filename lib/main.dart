import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:lenskart_clone/firebase_options.dart';
import 'app.dart';

void main() async {
  // Ensure that Flutter's binding is initialized
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());

  //print('firebase connected successfully');
}
