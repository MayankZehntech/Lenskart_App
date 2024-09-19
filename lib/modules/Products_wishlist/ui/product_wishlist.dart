import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lenskart_clone/modules/Common_glasses/model/eyeglass_model.dart';
import 'package:lenskart_clone/modules/Products_carts/ui/products_carts.dart';
import 'package:lenskart_clone/modules/Products_wishlist/ui/bloc/wishlist_bloc.dart';

class ProductWishlistPage extends StatefulWidget {
  const ProductWishlistPage({super.key});

  @override
  State<ProductWishlistPage> createState() => _ProductWishlistPageState();
}

class _ProductWishlistPageState extends State<ProductWishlistPage> {
  TextStyle _textStyleProductHeading() {
    return const TextStyle(
        fontFamily: 'poppins',
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: Color.fromARGB(244, 77, 76, 76));
  }

  TextStyle _textStyleProductPriceHeading() {
    return const TextStyle(
        fontFamily: 'poppins',
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: Color.fromARGB(255, 25, 219, 171));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Wishlist',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 15),
              child: InkWell(
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
            ),
          ],
        ),
        body: BlocBuilder<WishlistBloc, WishlistState>(
          builder: (context, state) {
            if (state.wishlist.isEmpty) {
              return const Center(
                child: Text('No items in wishlist.'),
              );
            }
            return ListView.builder(
              itemCount: state.wishlist.length,
              itemBuilder: (context, index) {
                final eyeglass = state.wishlist[index];

                return Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  width: MediaQuery.of(context).size.width,
                  height: 100,
                  decoration: const BoxDecoration(
                    border: Border.symmetric(
                        horizontal: BorderSide(color: Colors.black26)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 2.5,
                        child: Image.network(
                          eyeglass.photos[0],
                          fit: BoxFit.cover,
                        ),
                      ),

                      // product heading and price
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 150,
                            child: Text(
                              eyeglass.name,
                              style: _textStyleProductHeading(),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Text(
                            '₹${eyeglass.price}',
                            style: _textStyleProductPriceHeading(),
                          )
                        ],
                      ),

                      //bin and remove button
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(),
                          IconButton(
                              onPressed: () {
                                _showRemoveDialog(context, eyeglass);
                              },
                              icon: const Icon(Icons.delete, size: 25))
                        ],
                      )
                    ],
                  ),
                );
              },
            );
          },
        ));
  }

  void _showRemoveDialog(BuildContext context, EyeglassModel eyeglass) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            'Remove Item',
            style: TextStyle(fontFamily: 'poppins'),
          ),
          content: const Text('Remove this product from your wishlist?',
              style: TextStyle(fontFamily: 'poppins')),
          actions: <Widget>[
            TextButton(
              child: const Text('No'),
              onPressed: () {
                Navigator.of(context)
                    .pop(); // Close the dialog without removing
              },
            ),
            TextButton(
              child: const Text('Yes'),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
                context
                    .read<WishlistBloc>()
                    .add(RemoveFromWishlist(eyeglass)); // Remove from wishlist
              },
            ),
          ],
        );
      },
    );
  }
}
