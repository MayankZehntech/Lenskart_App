import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:lenskart_clone/modules/Login/bloc/login_bloc.dart';
import 'package:lenskart_clone/modules/Login/ui/login_screen.dart';
import 'package:lenskart_clone/modules/MyProfile/bloc/profile_bloc.dart';
import 'package:lenskart_clone/modules/Products_carts/ui/products_carts.dart';
import 'package:lenskart_clone/modules/Products_wishlist/ui/product_wishlist.dart';
import 'package:lenskart_clone/modules/Search_tap/ui/search_screen.dart';
import 'package:lenskart_clone/services/user_info_service.dart';

import 'package:lenskart_clone/widgets/myProfile/myProfile_list_custom.dart';

import 'package:lenskart_clone/widgets/myProfile/user_profile.dart';

class MyProfile extends StatefulWidget {
  const MyProfile({super.key});

  @override
  State<MyProfile> createState() => _MyProfileState();
}

TextStyle listFontStyle() {
  return const TextStyle(
      fontFamily: 'poppins',
      fontSize: 13,
      fontWeight: FontWeight.w500,
      color: Color.fromARGB(255, 1, 30, 73));
}

TextStyle listHeadingFontStyle() {
  return const TextStyle(
      fontFamily: 'poppins',
      fontSize: 17,
      fontWeight: FontWeight.bold,
      color: Color.fromARGB(255, 1, 30, 73));
}

class _MyProfileState extends State<MyProfile> {
  @override
  Widget build(BuildContext context) {
    // Get the current user
    final User? currentUser = FirebaseAuth.instance.currentUser;

    // Check if the user is logged in
    final String uid = currentUser?.uid ?? '';

    return BlocProvider(
      create: (context) => LoginBloc(
          FirebaseAuth.instance,
          GoogleSignIn(),
          UserInfoService(FirebaseAuth.instance, FirebaseFirestore.instance,
              FirebaseStorage.instance)),
      child: Scaffold(
        appBar: _buildAppbar(context),
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(18),
            color: const Color.fromARGB(97, 236, 236, 236),
            child: Column(
              children: [
                // user info container
                BlocBuilder<ProfileBloc, ProfileState>(
                  builder: (context, state) {
                    return UserProfileSection(uid: uid);
                  },
                ),

                // order wishlist wallet section

                const MyProfileOrderWishlistSection(),

                const SizedBox(
                  height: 15,
                ),

                //My eyes section
                CustomSection(
                  heading: 'My Eyes',
                  tileTitles: const [
                    'My saved powers',
                    'My frame size',
                    'AR try-on 1000+ frames',
                    'My saved 3D models'
                  ],
                  tileImages: const [
                    'assets/images/mysavedeyepower.webp',
                    'assets/images/Frame Size.webp',
                    'assets/images/ARtryON.webp',
                    'assets/images/Mysaved3Dmodels.webp'
                  ],
                  onTap: () {},
                ),

                const SizedBox(
                  height: 15,
                ),

                //Buy in store section
                CustomSection(
                  heading: 'Buy in Store',
                  tileTitles: const [
                    'Find nearby store',
                    'Book free eye test in store'
                  ],
                  tileImages: const [
                    'assets/images/findNearLocation.webp',
                    'assets/images/Bookeyetest.webp'
                  ],
                  onTap: () {},
                ),

                const SizedBox(
                  height: 15,
                ),

                //Lenskart @Home section
                CustomSection(
                  heading: 'Lenkart @ Home',
                  tileTitles: const ['Eye test & frame trial at home'],
                  tileImages: const ['assets/images/TryAthome.webp'],
                  onTap: () {},
                ),
                const SizedBox(
                  height: 15,
                ),

                //Buy with expert section

                CustomSection(
                  heading: 'Buy with expert help',
                  tileTitles: const [
                    'Chat with an eyewear Expert',
                    'Call an eyewear Expert'
                  ],
                  tileImages: const [
                    'assets/images/icon-profile-buy-on-chat.webp',
                    'assets/images/Support.webp'
                  ],
                  onTap: () {},
                ),
                const SizedBox(
                  height: 15,
                ),

                //Get Help section

                CustomSection(
                  heading: 'Get Help',
                  tileTitles: const [
                    'Frequently asked questions',
                    'Contact us'
                  ],
                  tileImages: const [
                    'assets/images/FAQ.webp',
                    'assets/images/Contact Us.webp'
                  ],
                  onTap: () {},
                ),
                const SizedBox(
                  height: 15,
                ),

                BlocConsumer<LoginBloc, LoginState>(
                  listener: (context, state) {
                    if (state is LogoutSuccess) {
                      // Show success message before navigation
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: const Center(
                            child: Text(
                              'LogOut successfully',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          backgroundColor: Colors.blue[900],
                        ),
                      );

                      // Navigate to LoginScreen after showing snackbar
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LoginScreen(),
                        ),
                        (route) => false,
                      );
                    } else if (state is LogoutFail) {
                      // Show error message
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            state.error,
                            style: const TextStyle(color: Colors.white),
                          ),
                          backgroundColor: Colors.red,
                        ),
                      );
                    }
                  },
                  builder: (context, state) {
                    if (state is LogoutLoading) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    return CustomSection(
                      heading: 'Others',
                      tileTitles: const [
                        'About Lenskart',
                        'Manage Notification',
                        'Logout'
                      ],
                      tileImages: const [
                        'assets/images/InfoAboutLenskart.webp',
                        'assets/images/manageNotification.webp',
                        'assets/images/logout.webp'
                      ],
                      onTap: () {
                        context.read<LoginBloc>().add(LogoutRequested());
                      },
                    );
                  },
                ),
                const SizedBox(height: 15),

                //lenkart version

                const Text(
                  'Lenskart @ 2017',
                  style: TextStyle(
                    fontFamily: 'poppins',
                    fontSize: 12,
                    fontWeight: FontWeight.normal,
                    color: Color.fromARGB(255, 122, 122, 122),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  'Version 4.4.5-240824001',
                  style: TextStyle(
                      fontFamily: 'poppins',
                      fontSize: 12,
                      fontWeight: FontWeight.normal,
                      color: Color.fromARGB(255, 122, 122, 122)),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  AppBar _buildAppbar(BuildContext context) {
    return AppBar(
      title: const Text(
        'My Profile',
        style: TextStyle(
            fontFamily: 'poppins', fontWeight: FontWeight.w800, fontSize: 18),
      ),
      actions: [
        Row(
          children: [
            IconButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SearchPage()));
                },
                icon: const Icon(
                  Icons.search_outlined,
                  size: 25,
                  color: Color.fromARGB(255, 1, 30, 73),
                )),
            const SizedBox(
              width: 5,
            ),
            InkWell(
              onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ProductWishlistPage(),
                  )),
              child: Image.asset(
                'assets/images/heart.webp',
                width: 25,
              ),
            ),
            const SizedBox(
              width: 18,
            ),
            Padding(
              padding: const EdgeInsets.only(right: 15),
              child: InkWell(
                onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ProductsCarts(),
                    )),
                child: Image.asset(
                  'assets/images/shopping-bag-02.webp',
                  width: 25,
                ),
              ),
            )
          ],
        )
      ],
    );
  }
}

class MyProfileOrderWishlistSection extends StatelessWidget {
  const MyProfileOrderWishlistSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 18),
      child: Row(
        children: [
          Image.asset(
            'assets/images/orders.webp',
            fit: BoxFit.cover,
            width: 108,
          ),
          const SizedBox(
            width: 12,
          ),
          InkWell(
            onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ProductWishlistPage(),
                )),
            child: Image.asset(
              'assets/images/wishlist.webp',
              fit: BoxFit.cover,
              width: 108,
            ),
          ),
          const SizedBox(
            width: 12,
          ),
          Image.asset(
            'assets/images/GetTheApp.webp',
            fit: BoxFit.cover,
            width: 108,
          ),
        ],
      ),
    );
  }
}
