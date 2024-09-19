import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lenskart_clone/modules/Common_glasses/model/eyeglass_model.dart';
import 'package:lenskart_clone/modules/Home/ui/home_screen.dart';
// import 'package:lenskart_clone/modules/Home/ui/home_screen.dart';
import 'package:lenskart_clone/modules/Products_carts/bloc/cart_bloc.dart';
import 'package:lenskart_clone/widgets/cart_page/bottomNavbar.dart';
import 'package:lenskart_clone/widgets/cart_page/bottom_navbar_bottom.dart';
import 'package:lenskart_clone/widgets/cart_page/cart_item_list.dart';

class ProductsCarts extends StatelessWidget {
  const ProductsCarts({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: BlocBuilder<CartBloc, CartState>(
        builder: (context, state) {
          if (state is CartEmpty || state is CartInitial) {
            //cart empty page if there no items in cart
            return cartEmptyPage(context);
          } else if (state is CartUpdated && state.cartItems.isNotEmpty) {
            return Column(
              children: [
                Expanded(
                  child: CartItemsList(cartItems: state.cartItems),
                ),
                BottomNavbar(
                    totalPrice: _calculateTotalPrice(state.cartItems) - 800),
              ],
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }

  Column cartEmptyPage(BuildContext context) {
    return Column(
      children: [
        const Expanded(
          child: Center(
            child: Text(
              'Your cart is currently empty.',
              style: TextStyle(
                  fontSize: 20,
                  fontFamily: 'poppins',
                  fontWeight: FontWeight.w800),
            ),
          ),
        ),
        BottomNavbarButton(
          onPress: () {
            // Navigate to the next page
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const HomeScreen(),
                )); // Replace with your actual route name
          },
          buttonText: 'Continue Shopping',
        )
      ],
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      title: const Text('Cart',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
    );
  }

  int _calculateTotalPrice(List<EyeglassModel> cartItems) {
    return cartItems.fold(0, (sum, item) => sum + item.price.toInt());
  }
}
