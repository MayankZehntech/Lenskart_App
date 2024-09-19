import 'package:flutter/material.dart';
import 'package:lenskart_clone/modules/Common_glasses/model/eyeglass_model.dart';
import 'package:lenskart_clone/widgets/cart_page/bill_details.dart';
import 'package:lenskart_clone/widgets/cart_page/cart_item_card.dart';

class CartItemsList extends StatelessWidget {
  final List<EyeglassModel> cartItems;

  const CartItemsList({super.key, required this.cartItems});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        color: const Color.fromARGB(246, 241, 238, 238),
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: cartItems.length,
              itemBuilder: (context, index) {
                return CartItemCard(eyeglass: cartItems[index]);
              },
            ),
            BillDetails(cartItems: cartItems),
            Image.network(
              'https://static5.lenskart.com/media/uploads/Condition.png',
              height: 120,
              fit: BoxFit.contain,
            ),
          ],
        ),
      ),
    );
  }
}
