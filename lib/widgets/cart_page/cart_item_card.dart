import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lenskart_clone/modules/Common_glasses/model/eyeglass_model.dart';
import 'package:lenskart_clone/modules/Products_carts/bloc/cart_bloc.dart';
import 'package:lenskart_clone/modules/Products_wishlist/ui/bloc/wishlist_bloc.dart';

class CartItemCard extends StatelessWidget {
  final EyeglassModel eyeglass;

  const CartItemCard({super.key, required this.eyeglass});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 175,
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: const BoxDecoration(
        color: Color.fromARGB(104, 255, 255, 255),
        borderRadius: BorderRadius.all(Radius.circular(18)),
      ),
      child: Row(
        children: [
          _ProductImage(eyeglass.photos[0]),
          _ProductDetails(eyeglass: eyeglass),
        ],
      ),
    );
  }
}

class _ProductImage extends StatelessWidget {
  final String imageUrl;

  const _ProductImage(this.imageUrl);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width / 2.6,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(18),
          bottomLeft: Radius.circular(18),
        ),
      ),
      child: Image.network(
        imageUrl,
        fit: BoxFit.contain,
        height: MediaQuery.of(context).size.height,
      ),
    );
  }
}

class _ProductDetails extends StatelessWidget {
  final EyeglassModel eyeglass;

  const _ProductDetails({required this.eyeglass});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 206,
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTitleAndRemoveButton(context, eyeglass),
          Text('Medium', style: _textStyleSubHeading()),
          const SizedBox(height: 10),
          _buildDescription(eyeglass),
          const SizedBox(height: 10),
          Text('Zero Power', style: _textStylePriceHeading()),
          const SizedBox(height: 20),
          _buildPriceInfo(eyeglass.price),
        ],
      ),
    );
  }

  Row _buildTitleAndRemoveButton(BuildContext context, EyeglassModel eyeglass) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          width: 130,
          child: Text(
            eyeglass.name,
            style: _textStyleHeading(),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        InkWell(
          child: const Icon(Icons.close, size: 15),
          onTap: () => _showRemoveDialog(context, eyeglass),
        ),
      ],
    );
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
          content: const Text(
            'Remove the item or add it to the wishlist?',
            style: TextStyle(fontFamily: 'poppins'),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Remove'),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
                context
                    .read<CartBloc>()
                    .add(RemoveFromCart(eyeglass)); // Remove from cart
              },
            ),
            TextButton(
              child: const Text('Add to Wishlist'),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
                context
                    .read<CartBloc>()
                    .add(RemoveFromCart(eyeglass)); // Remove from cart
                context
                    .read<WishlistBloc>()
                    .add(AddToWishlist(eyeglass)); // Add to wishlist
              },
            ),
          ],
        );
      },
    );
  }

  Column _buildDescription(EyeglassModel eyeglass) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          width: 190,
          child: Text(
            'Anti-Glare Normal Corridor Progressive lenses',
            style: TextStyle(
              fontFamily: 'poppins',
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: Color.fromARGB(255, 6, 48, 82),
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        SizedBox(
          width: 190,
          child: Text(
            eyeglass.subheading,
            style: _textStyleSubHeading(),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  Column _buildPriceInfo(double price) {
    return Column(
      children: [
        _buildLine(),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Frame + Lens', style: _textStyleBoldSubHeading()),
            Text('₹$price', style: _textStylePriceHeading())
          ],
        ),
      ],
    );
  }

  Container _buildLine() {
    return Container(
      height: 1,
      decoration: const BoxDecoration(
        border: Border(top: BorderSide(color: Color.fromARGB(255, 99, 99, 99))),
      ),
    );
  }

  TextStyle _textStyleHeading() {
    return const TextStyle(
        fontFamily: 'poppins',
        fontSize: 12,
        fontWeight: FontWeight.w600,
        color: Color.fromARGB(255, 6, 48, 82));
  }

  TextStyle _textStyleSubHeading() {
    return const TextStyle(
        fontFamily: 'poppins',
        fontSize: 11,
        fontWeight: FontWeight.w500,
        color: Color.fromARGB(244, 128, 127, 127));
  }

  TextStyle _textStyleBoldSubHeading() {
    return const TextStyle(
        fontFamily: 'poppins',
        fontSize: 11,
        fontWeight: FontWeight.w600,
        color: Color.fromARGB(244, 128, 127, 127));
  }

  TextStyle _textStylePriceHeading() {
    return const TextStyle(
        fontFamily: 'poppins',
        fontSize: 12,
        fontWeight: FontWeight.w600,
        color: Color.fromARGB(255, 6, 48, 82));
  }

  TextStyle cartProductTotalPriceHeading() {
    return const TextStyle(
        fontFamily: 'poppins',
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: Color.fromARGB(255, 2, 26, 46));
  }

  TextStyle cartHeading() {
    return const TextStyle(
        fontFamily: 'poppins', fontSize: 20, fontWeight: FontWeight.w600);
  }
}
