import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lenskart_clone/modules/Common_glasses/bloc/glasses_bloc.dart';
import 'package:lenskart_clone/modules/Products_carts/ui/products_carts.dart';
import 'package:lenskart_clone/modules/Products_wishlist/ui/product_wishlist.dart';
import 'package:lenskart_clone/modules/Search_tap/ui/search_screen.dart';

import 'package:lenskart_clone/services/firebase_service.dart';

import 'package:lenskart_clone/widgets/common_glasses/products_card.dart';

// ignore: must_be_immutable
class CommonGlassesScreen extends StatefulWidget {
  final String genderType;
  final String glassesCategory;
  const CommonGlassesScreen(
      {super.key, required this.genderType, required this.glassesCategory});

  @override
  State<CommonGlassesScreen> createState() => _CommonGlassesState();
}

class _CommonGlassesState extends State<CommonGlassesScreen> {
  final List<String> imagePaths = [
    'assets/images/mens/menclassic-plp-27Aug24.webp',
    'assets/images/mens/VC_men_eye_2.webp',
    'assets/images/mens/VC_high_quality.webp',
  ];

  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    // _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    //print('Scroll position: ${_scrollController.position.pixels}');
    context
        .read<GlassesBloc>()
        .add(ScrollUpdated(_scrollController.position.pixels));
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GlassesBloc(EyeglassService())
        ..add(FetchEyeglasses(widget.genderType, widget.glassesCategory)),
      child: Scaffold(
        body: Stack(
          children: [
            CustomScrollView(
              controller: _scrollController,
              slivers: [
                SliverAppBar(
                  automaticallyImplyLeading: false,
                  expandedHeight: 225,
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  pinned: true,
                  flexibleSpace: Stack(
                    children: [
                      CarouselSlider(
                        options: CarouselOptions(
                          height: 250,
                          autoPlay: true,
                          viewportFraction: 1.0,
                          onPageChanged: (index, reason) {
                            context.read<GlassesBloc>().add(TabChanged(index));
                          },
                        ),
                        items: imagePaths.map((imagePath) {
                          return Builder(
                            builder: (BuildContext context) {
                              return Image.asset(
                                imagePath,
                                fit: BoxFit.contain,
                                width: MediaQuery.of(context).size.width,
                              );
                            },
                          );
                        }).toList(),
                      ),
                      Positioned(
                        bottom: 10,
                        left: 0,
                        right: 0,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(
                            imagePaths.length,
                            (index) => Container(
                              width: 8,
                              height: 8,
                              margin: const EdgeInsets.symmetric(horizontal: 4),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: context
                                            .watch<GlassesBloc>()
                                            .state
                                            .selectedIndex ==
                                        index
                                    ? const Color.fromARGB(255, 1, 40, 71)
                                    : Colors.grey,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  // Removing the flexibleSpace from here
                ),

                SliverToBoxAdapter(
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        border: BorderDirectional(
                          bottom: BorderSide(
                              color: Color.fromARGB(255, 219, 218, 218),
                              width: 1),
                        ),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black26,
                              offset: Offset(0, 3),
                              blurRadius: 6,
                              spreadRadius: 1)
                        ]),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildTab('All', 0, 'assets/images/mens/All-New.webp'),
                        _buildTab('Bestsellers', 1,
                            'assets/images/mens/icon-best-seller.webp'),
                        _buildTab('New Arrivals', 2,
                            'assets/images/mens/icon-new-arrivals.webp'),
                      ],
                    ),
                  ),
                ),

                //here
                //here
                //here
                //here
                //here
                // Products Cards
                GlassesProductCard()
              ],
            ),
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: BlocBuilder<GlassesBloc, GlassesState>(
                  builder: (context, state) {
                //print('Maynk classes ${state.isAppBarWhite}');
                return Container(
                  color: Colors.white,

                  //padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: AppBar(
                    backgroundColor: Colors.white,
                    elevation: 0,
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Glasses',
                          style: TextStyle(
                              color: Color.fromARGB(255, 1, 41, 73),
                              fontWeight: FontWeight.w600,
                              fontFamily: 'poppins'),
                        ),
                        Row(
                          children: [
                            CircleAvatar(
                              backgroundColor: Colors.white.withOpacity(0.7),
                              child: IconButton(
                                icon: const Icon(Icons.search_outlined,
                                    color: Colors.black),
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const SearchPage(),
                                      ));
                                },
                              ),
                            ),
                            const SizedBox(width: 10),

                            //wishlist icon
                            CircleAvatar(
                              backgroundColor: Colors.white.withOpacity(0.7),
                              child: InkWell(
                                onTap: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const ProductWishlistPage(),
                                    )),
                                child: Image.asset(
                                  'assets/images/heart.webp',
                                  width: 25,
                                ),
                              ),
                            ),
                            const SizedBox(width: 15),

                            //cart icon
                            CircleAvatar(
                              backgroundColor: Colors.white.withOpacity(0.7),
                              child: InkWell(
                                child: Image.asset(
                                  'assets/images/shopping-bag-02.webp',
                                  width: 25,
                                ),
                                onTap: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const ProductsCarts(),
                                    )),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }

  // ignore: non_constant_identifier_names
  SliverToBoxAdapter GlassesProductCard() {
    return SliverToBoxAdapter(
      child: Container(
        color: const Color.fromARGB(188, 235, 229, 229),
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        child: const ProductsCards(),
      ),
    );
  }

  Widget _buildTab(String title, int index, String imageOptions) {
    return BlocBuilder<GlassesBloc, GlassesState>(
      builder: (context, state) {
        final isSelected = state.selectedIndex == index;
        return GestureDetector(
          onTap: () {
            //context.read<GlassesBloc>().add(TabChanged(index));
          },
          child: Column(
            children: [
              Image.asset(
                imageOptions,
                width: 33,
              ),
              //const SizedBox(height: 0),
              Text(
                title,
                style: TextStyle(
                    color: isSelected ? Colors.black : Colors.grey,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'poppins'),
              ),
              if (isSelected)
                Container(
                  margin: const EdgeInsets.only(top: 4),
                  height: 2,
                  width: 40,
                  color: Colors.blue[900],
                ),
            ],
          ),
        );
      },
    );
  }
}
