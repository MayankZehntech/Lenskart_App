import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lenskart_clone/modules/Home/bloc/home_bloc.dart';
import 'package:lenskart_clone/modules/MyProfile/bloc/profile_bloc.dart';

import 'package:lenskart_clone/modules/MyProfile/ui/my_profile.dart';
import 'package:lenskart_clone/modules/Products_carts/ui/products_carts.dart';
import 'package:lenskart_clone/modules/Products_wishlist/ui/product_wishlist.dart';
import 'package:lenskart_clone/services/current_location_service.dart';
import 'package:lenskart_clone/services/user_info_service.dart';

class HomeAppbarSection extends StatefulWidget {
  const HomeAppbarSection({
    super.key,
  });

  @override
  State<HomeAppbarSection> createState() => _HomeAppbarSectionState();
}

class _HomeAppbarSectionState extends State<HomeAppbarSection> {
  @override
  Widget build(BuildContext context) {
    final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    final UserInfoService userService = UserInfoService(
        firebaseAuth, FirebaseFirestore.instance, FirebaseStorage.instance);

    return SliverAppBar(
      automaticallyImplyLeading: false,
      floating: true,
      snap: true,
      title: Row(
        children: [
          BlocBuilder<ProfileBloc, ProfileState>(
            builder: (context, state) {
              return FutureBuilder<Map<String, dynamic>?>(
                  future: userService
                      .getUserInfo(firebaseAuth.currentUser?.uid ?? ''),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      var userInfo = snapshot.data!;
                      return ProfileNavigation(userInfo: userInfo);
                    } else {
                      return const DefaultProfileNavigation();
                    }
                  });
            },
          ),
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Get faster delivery',
                style: TextStyle(
                  fontFamily: 'poppins',
                  fontSize: 12,
                  color: Colors.orange[900],
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 5),
              BlocProvider(
                create: (context) =>
                    HomeBloc(LocationService())..add(FetchLocation()),
                child: BlocBuilder<HomeBloc, HomeState>(
                  builder: (context, state) {
                    if (state is LocationLoading) {
                      return const Text(
                        'Fetching location...',
                        style: TextStyle(
                          fontFamily: 'poppins',
                          fontSize: 12,
                          color: Color.fromARGB(255, 1, 30, 73),
                        ),
                      );
                    } else if (state is LocationLoaded) {
                      return Text(
                        'Location: ${state.cityName}',
                        //'Location: ${state.position.latitude}, ${state.position.longitude} >',
                        style: const TextStyle(
                          fontFamily: 'poppins',
                          fontSize: 12,
                          color: Color.fromARGB(255, 1, 30, 73),
                        ),
                      );
                    } else if (state is LocationError) {
                      return const Text(
                        'Location not found >',
                        style: TextStyle(
                          fontFamily: 'poppins',
                          fontSize: 12,
                          color: Color.fromARGB(255, 1, 30, 73),
                        ),
                      );
                    }
                    return const Text(
                      'Select Location >',
                      style: TextStyle(
                        fontFamily: 'poppins',
                        fontSize: 12,
                        color: Color.fromARGB(255, 1, 30, 73),
                      ),
                    );
                  },
                ),
              ),
              // const Text(
              //   'Select Location >',
              //   style: TextStyle(
              //     fontFamily: 'poppins',
              //     fontSize: 12,
              //     color: Color.fromARGB(255, 1, 30, 73),
              //   ),
              // ),
            ],
          ),
        ],
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 15),
          child: Row(
            children: [
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ProductWishlistPage(),
                      ));
                },
                child: Image.asset(
                  'assets/images/heart.webp',
                  width: 25,
                ),
              ),
              const SizedBox(width: 15),
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ProductsCarts(),
                      ));
                },
                child: Image.asset(
                  'assets/images/shopping-bag-02.webp',
                  width: 25,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class DefaultProfileNavigation extends StatelessWidget {
  const DefaultProfileNavigation({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // Profile navigation code
        Navigator.push(
          context,
          PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) =>
                  const MyProfile(),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                const begin = Offset(0.0, 1.0); // Start from bottom
                const end = Offset.zero; // End at the center (normal position)
                const curve = Curves.ease;

                var tween = Tween(begin: begin, end: end).chain(
                  CurveTween(curve: curve),
                );

                return SlideTransition(
                  position: animation.drive(tween),
                  child: child,
                );
              },
              transitionDuration: const Duration(milliseconds: 100)),
        );
      },
      child: const CircleAvatar(
        backgroundColor: Color.fromARGB(73, 138, 89, 148),
        child: Text('K'),
      ),
    );
  }
}

class ProfileNavigation extends StatefulWidget {
  const ProfileNavigation({
    super.key,
    required this.userInfo,
  });

  final Map<String, dynamic> userInfo;

  @override
  State<ProfileNavigation> createState() => _ProfileNavigationState();
}

class _ProfileNavigationState extends State<ProfileNavigation> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // Profile navigation code
        Navigator.push(
          context,
          PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) =>
                  const MyProfile(),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                const begin = Offset(0.0, 1.0); // Start from bottom
                const end = Offset.zero; // End at the center (normal position)
                const curve = Curves.ease;

                var tween = Tween(begin: begin, end: end).chain(
                  CurveTween(curve: curve),
                );

                return SlideTransition(
                  position: animation.drive(tween),
                  child: child,
                );
              },
              transitionDuration: const Duration(milliseconds: 200)),
        );
      },
      child: CircleAvatar(
        radius: 20,
        backgroundColor: Colors.purple[50],
        backgroundImage: NetworkImage(widget.userInfo['photoUrl']),
      ),
    );
  }
}
