import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lenskart_clone/modules/Common_glasses/bloc/glasses_bloc.dart';
import 'package:lenskart_clone/modules/Products_carts/bloc/cart_bloc.dart';
import 'package:lenskart_clone/modules/Products_carts/ui/products_carts.dart';
import 'package:lenskart_clone/modules/Products_wishlist/ui/bloc/wishlist_bloc.dart';
import 'package:lenskart_clone/widgets/common_glasses/dash_line.dart';

class ProductsCards extends StatelessWidget {
  const ProductsCards({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GlassesBloc, GlassesState>(builder: (context, state) {
      if (state is EyeglassLoading) {
        return const Center(child: CircularProgressIndicator());
      } else if (state is EyeglassLoaded) {
        if (state.eyeglasses.isEmpty) {
          return const Center(
            child: Text('No eyeglasses available'),
          );
        }
        return ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.all(10),
            itemCount: state.eyeglasses.length,
            //itemCount: 3,
            itemBuilder: (context, index) {
              final eyeglass = state.eyeglasses[index];

              // Trigger checking of wishlist status for this product
              //context.read<WishlistBloc>().add(CheckWishlistStatus(eyeglass));

              return BlocBuilder<WishlistBloc, WishlistState>(
                  builder: (context, wishlistState) {
                bool isWishlisted = wishlistState.wishlist.contains(eyeglass);

                return Container(
                  height: 400,
                  //width: 300,
                  margin: const EdgeInsets.only(bottom: 15),
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 245, 245, 245),
                    borderRadius: BorderRadius.all(Radius.circular(18)),
                  ),

                  child: Column(
                    children: [
                      Stack(children: [
                        ClipRRect(
                          borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(18)),
                          child: CarouselSlider(
                            options: CarouselOptions(
                              height: 250,
                              //autoPlay: true,
                              viewportFraction: 1.0,
                            ),
                            items: eyeglass.photos.map((imageUrl) {
                              return Image.network(
                                imageUrl,
                                height: 250,
                                width: double.infinity,
                                fit: BoxFit.cover,
                              );
                            }).toList(),
                          ),
                        ),
                        Positioned(
                          bottom: 10,
                          left: 10,
                          child: Image.asset(
                            'assets/images/mens/view_similar.png',
                            width: 100,
                          ),
                        ),
                        Positioned(
                          bottom: 10,
                          right: 10,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 2, horizontal: 6),
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(29, 77, 118, 151),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  '4.6',
                                  style: TextStyle(
                                    color: Color.fromARGB(255, 1, 45, 82),
                                    fontSize: 11,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                SizedBox(width: 3),
                                Icon(
                                  Icons.star,
                                  color: Color.fromARGB(255, 1, 45, 82),
                                  size: 12,
                                ),
                              ],
                            ),
                          ),
                        ),
                        //wishlist icon
                        Positioned(
                            top: 20,
                            right: 20,
                            child: InkWell(
                              onTap: () {
                                if (isWishlisted) {
                                  context
                                      .read<WishlistBloc>()
                                      .add(RemoveFromWishlist(eyeglass));
                                } else {
                                  context
                                      .read<WishlistBloc>()
                                      .add(AddToWishlist(eyeglass));
                                }
                              },
                              child: Icon(
                                isWishlisted
                                    ? Icons.favorite
                                    : Icons.favorite_border,
                                color: isWishlisted ? Colors.red : Colors.grey,
                                size: 24,
                              ),
                            )
                            // },
                            ),
                      ]),
                      Container(
                        padding: const EdgeInsets.only(
                            left: 10, right: 10, top: 8, bottom: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                //color of glasses
                                Text(
                                  eyeglass.color,
                                  style: const TextStyle(
                                    fontSize: 12,
                                    fontFamily: 'poppins',
                                  ),
                                ),

                                InkWell(
                                  onTap: () {
                                    context
                                        .read<CartBloc>()
                                        .add(AddToCart(eyeglass));
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const ProductsCarts(),
                                        ));
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(6),
                                    decoration: const BoxDecoration(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(12)),
                                      color: Color.fromARGB(255, 7, 42, 75),
                                    ),
                                    child: const Text(
                                      'Add to cart',
                                      style: TextStyle(
                                          fontFamily: 'poppins',
                                          fontSize: 10,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.white),
                                    ),
                                  ),
                                ),

                                Container(
                                  height: 20,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: const Color.fromARGB(
                                            255, 155, 231, 158)),
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(4)),
                                  ),
                                  child: Row(
                                    children: [
                                      const Padding(
                                        padding: EdgeInsets.only(left: 5),
                                        child: Text(
                                          'Medium',
                                          style: TextStyle(
                                            fontSize: 10,
                                            fontFamily: 'poppins',
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 5),
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(4),
                                        child: Image.asset(
                                          'assets/images/mens/Perfect_Fit,_Old_copy.webp',
                                          width: 18,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                            const SizedBox(height: 12),

                            //card heading
                            Text(
                              eyeglass.name,
                              style: const TextStyle(
                                  fontFamily: 'poppins',
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600),
                            ),

                            //glass subheading and price
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  eyeglass.subheading,
                                  style: const TextStyle(
                                      fontFamily: 'poppins',
                                      fontSize: 12,
                                      color:
                                          Color.fromARGB(255, 126, 126, 126)),
                                ),
                                Text(
                                  '₹${eyeglass.price}',
                                  style: const TextStyle(
                                      fontFamily: 'poppins',
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600),
                                )
                              ],
                            ),
                            const SizedBox(height: 12),

                            // Dashed line
                            DashLine(context: context),
                            const SizedBox(height: 12),

                            // below coupan offer part

                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                RichText(
                                    text: const TextSpan(
                                        style: TextStyle(
                                            fontFamily: 'poppins',
                                            color: Colors.grey,
                                            fontSize: 12),
                                        children: [
                                      TextSpan(text: 'Code: '),
                                      TextSpan(
                                          text: 'SINGLE',
                                          style: TextStyle(
                                              fontFamily: 'poppins',
                                              fontWeight: FontWeight.w600,
                                              color: Colors.black))
                                    ])),
                                Row(
                                  children: [
                                    Image.network(
                                      'https://static5.lenskart.com/media/uploads/sale-offer.png',
                                      width: 12,
                                    ),
                                    const SizedBox(width: 4),
                                    Text(
                                      'For ₹1200 with Free Lenses',
                                      style: TextStyle(
                                          fontFamily: 'poppins',
                                          color: Colors.blue[900],
                                          fontWeight: FontWeight.w600),
                                    )
                                  ],
                                )
                              ],
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                );
              });
            });
      } else if (state is EyeglassError) {
        return Center(child: Text(state.message));
      } else {
        return const Center(child: Text('No data available'));
      }
    });
  }
}
