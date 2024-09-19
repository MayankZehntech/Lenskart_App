import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lenskart_clone/modules/Home/bloc/home_bloc.dart';
import 'package:lenskart_clone/modules/Common_glasses/ui/common_glasses_screen.dart';
import 'package:lenskart_clone/modules/MyProfile/bloc/profile_bloc.dart';
// import 'package:lenskart_clone/modules/Products_wishlist/ui/bloc/wishlist_bloc.dart';

import 'package:lenskart_clone/modules/Search_tap/ui/search_screen.dart';
import 'package:lenskart_clone/widgets/Home/appbar_widget.dart';
import 'package:lenskart_clone/widgets/Home/exclusivly_at_lenskart.dart';
import 'package:lenskart_clone/widgets/Home/home_heading_with_images.dart';
import 'package:lenskart_clone/widgets/Home/home_image_slider.dart';
import 'package:lenskart_clone/widgets/Home/home_offer_heading_img.dart';
import 'package:lenskart_clone/widgets/Home/navbar_widget.dart';
import 'package:lenskart_clone/widgets/Home/sun_season_slider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController _scrollController = ScrollController();
  late HomeBloc homeBloc;

  @override
  void initState() {
    super.initState();
    homeBloc = context.read<HomeBloc>();
    _scrollController.addListener(() {
      if (_scrollController.position.userScrollDirection ==
          ScrollDirection.reverse) {
        homeBloc.add(ScrollDownEvent());
      } else if (_scrollController.position.userScrollDirection ==
          ScrollDirection.forward) {
        homeBloc.add(ScrollUpEvent());
      }
    });
  }

  List<String> imagePathForSlider = [
    'assets/images/slider_images/appp.webp',
    'assets/images/slider_images/Frame 1437257298.webp',
    'assets/images/slider_images/Harmony-DrivingGlasses.webp',
    'assets/images/slider_images/Harmony-top-banner-floatpop.png',
    'assets/images/slider_images/Harmony-top-banner-harrypotter.webp',
    'assets/images/slider_images/Harmony-top-banner-progressive.webp',
    'assets/images/slider_images/Homebanner-owndays.webp',
    'assets/images/slider_images/IndoorGlasses-HarmonyBanner.webp',
    'assets/images/slider_images/unbreakable-top-banner-.webp',
    'assets/images/slider_images/urban-home-3.webp'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          return Stack(children: [
            CustomScrollView(
              controller: _scrollController,
              slivers: [
                //home app bar widgets

                BlocBuilder<ProfileBloc, ProfileState>(
                  builder: (context, state) {
                    return const HomeAppbarSection();
                  },
                ),

                //search bar section

                SliverPersistentHeader(
                  pinned: true,
                  delegate: _SearchBarDelegate(),
                ),

                // home main content
                SliverToBoxAdapter(
                  child: Padding(
                    padding:
                        const EdgeInsets.only(top: 12, left: 15, right: 15),
                    child: ImageSlider(imagePath: imagePathForSlider),
                  ),
                ),

                //Eyeglasses Section
                SliverToBoxAdapter(
                    child: HeadingWithImages(
                        heading: 'Eyeglasses',
                        imagePaths: const [
                      'assets/images/grid_images/Home-All-grid-eyeglasses-Men-2_3.webp',
                      'assets/images/grid_images/Home-All-grid-eyeglasses-Women-2_3.png',
                      'assets/images/grid_images/Home-All-grid-eyeglasses-Kids-2_3.webp',
                      'assets/images/grid_images/Home-All-grid-eyeglasses-Reading-2_3.png'
                    ],
                        onImageTaps: [
                      () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const CommonGlassesScreen(
                                genderType: 'men',
                                glassesCategory: 'eyeglasses',
                              ),
                            ));
                        //     .then(
                        //   (value) {
                        //     context
                        //         .read<WishlistBloc>()
                        //         .add(CheckWishlistStatus());
                        //   },
                        // );
                      }, //men
                      () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const CommonGlassesScreen(
                                genderType: 'women',
                                glassesCategory: 'eyeglasses',
                              ),
                            ));
                        //     .then(
                        //   (value) {
                        //     context
                        //         .read<WishlistBloc>()
                        //         .add(CheckWishlistStatus());
                        //   },
                        // );
                      }, // women
                      () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const CommonGlassesScreen(
                                genderType: 'kids',
                                glassesCategory: 'eyeglasses',
                              ),
                            ));
                        //     .then(
                        //   (value) {
                        //     context
                        //         .read<WishlistBloc>()
                        //         .add(const CheckWishlistStatus());
                        //   },
                        // );
                      }, //kids
                      () {}, //progressive
                    ])),

                //Sunglasses Section
                SliverToBoxAdapter(
                    child: HeadingWithImages(
                        heading: 'Sunglasses',
                        imagePaths: const [
                      'assets/images/grid_images/Home-All-grid-sunglasses-Men-2_3.png',
                      'assets/images/grid_images/Home-All-grid-sunglasses-Women-2_3.webp',
                      'assets/images/grid_images/Home-All-grid-sunglasses-Kids-2_3.png',
                      'assets/images/grid_images/Home-All-grid-sunglasses-with Power-2_3.webp'
                    ],
                        onImageTaps: [
                      () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const CommonGlassesScreen(
                                genderType: 'men',
                                glassesCategory: 'sunglasses',
                              ),
                            ));
                      }, //men
                      () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const CommonGlassesScreen(
                                genderType: 'women',
                                glassesCategory: 'sunglasses',
                              ),
                            ));
                      }, // women
                      () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const CommonGlassesScreen(
                                genderType: 'kids',
                                glassesCategory: 'sunglasses',
                              ),
                            ));
                      }, //kids
                      () {}, //progressive
                    ])),

                //Screenglasses Section
                SliverToBoxAdapter(
                    child: HeadingWithImages(
                        heading: 'BLU Screen Glasses',
                        imagePaths: const [
                      'assets/images/grid_images/Home-All-grid-computer glasses-Men-2_3.png',
                      'assets/images/grid_images/Home-All-grid-computer glasses-women-2_3.png',
                      'assets/images/grid_images/Home-All-grid-computer glasses-kids-2_3.webp',
                      'assets/images/grid_images/Home-All-grid-computer glasses-BluBlock-2_3.webp'
                    ],
                        onImageTaps: [
                      () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const CommonGlassesScreen(
                                genderType: 'men',
                                glassesCategory: 'blueglasses',
                              ),
                            ));
                      }, //men
                      () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const CommonGlassesScreen(
                                genderType: 'women',
                                glassesCategory: 'blueglasses',
                              ),
                            ));
                      }, // women
                      () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const CommonGlassesScreen(
                                genderType: 'kids',
                                glassesCategory: 'blueglasses',
                              ),
                            ));
                      }, //kids
                      () {}, //progressive
                    ])),

                //Other needs Section
                SliverToBoxAdapter(
                    child: HeadingWithImages(
                        heading: 'Other Needs',
                        imagePaths: const [
                      'assets/images/grid_images/Home-All-grid-other-driving-eyeconic.webp',
                      'assets/images/grid_images/Home-All-grid-other-sports-eyeconic.webp',
                      'assets/images/grid_images/Home-All-grid-other-reading-eyeconic.png',
                      'assets/images/grid_images/Home-All-grid-other-cases-eyeconic.webp'
                    ],
                        onImageTaps: [
                      () {}, //men
                      () {}, // women
                      () {}, //kids
                      () {}, //progressive
                    ])),

                //Free lenses + 60% Off Section
                SliverToBoxAdapter(
                    child: HomeOfferHeadingImg(
                        heading: 'FreeLenses + 60% Off on Frames',
                        subtTitle: 'Starting at ₹800.Exclusive range',
                        imagePaths: const [
                      'assets/images/grid_images/Eyeconicsale-landing-page-OE-grid-eye.png',
                      'assets/images/grid_images/Eyeconicsale-landing-page-OE-grid-sun.webp',
                      'assets/images/grid_images/Eyeconicsale-landing-page-OE-grid-zero power.webp',
                    ],
                        onImageTaps: [
                      () {}, //men
                      () {}, // women
                      () {}, //kids
                    ])),

                // Hustlr image poster
                SliverToBoxAdapter(
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 15,
                      ),
                      Image.asset(
                          'assets/images/grid_images/Home-All-PremiumEyewear-top-Strip-10_1.webp'),
                      Image.asset('assets/images/grid_images/Hustlr.webp'),
                      Image.asset(
                          'assets/images/grid_images/Home-All-LenskartSpecial-bottom-Strip-10_1.webp'),
                      const SizedBox(
                        height: 15,
                      )
                    ],
                  ),
                ),

                //Exclusivly at lenskart

                SliverToBoxAdapter(
                  child: ExclusivlyLenskartGridWithHeading(
                      heading: 'Exclusively at Lenskart',
                      subheading: 'Get the perfect vision and style',
                      imagePaths: const [
                        'assets/images/grid_images/border_images/Home-genz-stories-exclusives-harrypotter.webp',
                        'assets/images/grid_images/border_images/Home-genz-stories-signatureseries-crystalclear.webp',
                        'assets/images/grid_images/border_images/Home-genz-stories-signatureseries-crystalclear-1.webp',
                        'assets/images/grid_images/border_images/Home-genz-stories-signatureseries-blublock.webp',
                        'assets/images/grid_images/border_images/Home-genz-stories-signatureseries-airflex.webp',
                        'assets/images/grid_images/border_images/Home-genz-stories-signatureseries-aquacolor.webp'
                      ],
                      onImageTaps: [
                        () {}, //men
                        () {}, // women
                        () {}, //kids
                        () {},
                        () {}, //men
                        () {}, // women
                      ]),
                ),

                //Sun season section
                SliverToBoxAdapter(
                    child: Image.asset(
                        'assets/images/grid_images/Home-All-NewAtLenskart-top-Strip-10_1.webp')),

                SliverToBoxAdapter(
                  child: Container(
                    color: const Color.fromARGB(178, 218, 232, 241),
                    child: Column(
                      children: [
                        SunSeasonHeadingAndSlider(
                            heading: 'Sun season specials',
                            imagePaths: const [
                              'assets/images/grid_images/border_images/Home-all-stories-sunseason-airport.webp',
                              'assets/images/grid_images/border_images/Home-all-stories-sunseason-reflector.webp',
                              'assets/images/grid_images/border_images/Home-all-stories-sunseason-rimless-1.webp',
                              'assets/images/grid_images/border_images/Home-all-stories-sunseason-rimless.webp',
                              'assets/images/grid_images/border_images/Home-all-stories-sunseason-vacation.webp',
                              'assets/images/grid_images/border_images/Home-alltab-stories-sunseason-biker.webp'
                            ]),

                        Image.asset(
                            'assets/images/grid_images/Home-All-ExploreAllLenses-Bottom-Strip-10_1.webp'),

                        //lenskart promise
                        Container(
                          color: Colors.white,
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Image.asset(
                                    'assets/images/grid_images/3x1 Banner.webp'),
                              ),
                              SunSeasonHeadingAndSlider(
                                  heading: 'Lenskart Promise',
                                  imageHeight: 100,
                                  imageWidth: 120,
                                  icon: Icons.assured_workload_outlined,
                                  imagePaths: const [
                                    'assets/images/grid_images/home-all-lenskart-promise.webp',
                                    'assets/images/grid_images/home-all-lenskart-promise1.webp',
                                    'assets/images/grid_images/home-all-lenskart-promise-why buy from Lk 3.webp',
                                    'assets/images/grid_images/home-all-lenskart-promise-why buy from Lk 4.webp',
                                    'assets/images/grid_images/home-all-lenskart-promise-why buy from Lk 5.webp',
                                    'assets/images/grid_images/home-all-lenskart-promise-why buy from Lk 6.webp',
                                    'assets/images/grid_images/home-all-lenskart-promise-why buy from Lk 7.webp',
                                  ]),
                              Image.asset(
                                  'assets/images/grid_images/Home-All-NewAtLenskart-top-Strip-10_1.webp')
                            ],
                          ),
                        ),

                        Image.asset(
                            'assets/images/grid_images/updated-home-new-do-more-be-more.webp'),

                        Image.asset(
                            'assets/images/grid_images/footer-top-1.webp'),

                        //Last footer banner image
                        Image.asset(
                            'assets/images/grid_images/footer-new-2.webp')
                      ],
                    ),
                  ),
                )
              ],
            ),
            // Navbar logic
            HomeNavbarSection(homeBloc: homeBloc),
          ]);
        },
      ),
    );
  }
}

class _SearchBarDelegate extends SliverPersistentHeaderDelegate {
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      padding: const EdgeInsets.only(top: 25, left: 15, right: 15, bottom: 15),
      color: Colors.white, // Ensure background matches the app design
      child: TextField(
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.search_outlined),
          suffixIcon: const Icon(Icons.camera_alt_outlined),
          hintText: 'Search...',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(
                color:
                    Color.fromARGB(255, 236, 236, 236)), // Color when focused
            borderRadius: BorderRadius.circular(15),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(
                color:
                    Color.fromARGB(255, 236, 236, 236)), // Color when enabled
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        readOnly: true,
        onTap: () {
          // Navigate to search page
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const SearchPage(),
              ));
        },
      ),
    );
  }

  @override
  double get maxExtent => 90.0;

  @override
  double get minExtent => 90.0;

  @override
  bool shouldRebuild(_SearchBarDelegate oldDelegate) => false;
}
