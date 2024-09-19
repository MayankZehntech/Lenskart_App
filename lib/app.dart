import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:lenskart_clone/modules/Common_glasses/bloc/glasses_bloc.dart';
import 'package:lenskart_clone/modules/Home/bloc/home_bloc.dart';
import 'package:lenskart_clone/modules/Login/bloc/login_bloc.dart';
import 'package:lenskart_clone/modules/MyProfile/bloc/profile_bloc.dart';
import 'package:lenskart_clone/modules/Products_carts/bloc/cart_bloc.dart';
import 'package:lenskart_clone/modules/Products_wishlist/ui/bloc/wishlist_bloc.dart';
// import 'package:lenskart_clone/modules/Common_glasses/bloc/mens_bloc.dart';
import 'package:lenskart_clone/modules/splash_screen/ui/splash_screen.dart';
import 'package:lenskart_clone/services/current_location_service.dart';
import 'package:lenskart_clone/services/firebase_service.dart';
import 'package:lenskart_clone/services/user_info_service.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
              create: (_) => LoginBloc(
                  FirebaseAuth.instance,
                  GoogleSignIn(),
                  UserInfoService(FirebaseAuth.instance,
                      FirebaseFirestore.instance, FirebaseStorage.instance))),
          BlocProvider(create: (_) => HomeBloc(LocationService())),
          BlocProvider(create: (_) => GlassesBloc(EyeglassService())),
          BlocProvider(create: (_) => CartBloc()),
          BlocProvider(create: (_) => WishlistBloc()),
          BlocProvider(
              create: (_) => ProfileBloc(UserInfoService(FirebaseAuth.instance,
                  FirebaseFirestore.instance, FirebaseStorage.instance))),
        ],
        child: MaterialApp(
          title: 'Lenskart',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(
                  seedColor: const Color.fromARGB(255, 3, 0, 44)),
              useMaterial3: true,
              scaffoldBackgroundColor: Colors.white),
          home: const SplashScreen(),
        ));
  }
}
