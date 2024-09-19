import 'package:flutter/material.dart';
import 'package:lenskart_clone/modules/Common_glasses/model/eyeglass_model.dart';
import 'package:lenskart_clone/widgets/common_glasses/dash_line.dart';

class BillDetails extends StatelessWidget {
  final List<EyeglassModel> cartItems;

  const BillDetails({super.key, required this.cartItems});

  @override
  Widget build(BuildContext context) {
    final totalPrice =
        cartItems.fold(0, (sum, item) => sum + item.price.toInt());
    final discountedPrice = totalPrice - 800;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Bill details',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'poppins')),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(18)),
            ),
            child: Column(
              children: [
                _buildPriceRow('Total item price', '₹$totalPrice'),
                DashLine(context: context),
                _buildPriceRow('Total discount', '-₹800'),
                singleStraightLine(),
                _buildPriceRow('Total payable', '₹$discountedPrice',
                    isTotal: true),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPriceRow(String title, String value, {bool isTotal = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
                fontFamily: 'poppins',
                fontSize: isTotal ? 16 : 13,
                fontWeight: isTotal ? FontWeight.w700 : FontWeight.w600,
                color: isTotal
                    ? const Color.fromARGB(255, 2, 27, 48)
                    : const Color.fromARGB(199, 2, 27, 48)),
          ),
          Text(value,
              style: TextStyle(
                  fontFamily: "poppins",
                  fontSize: isTotal ? 16 : 13,
                  fontWeight: isTotal ? FontWeight.w700 : FontWeight.w600,
                  color: isTotal
                      ? const Color.fromARGB(255, 2, 27, 48)
                      : const Color.fromARGB(199, 2, 27, 48))),
        ],
      ),
    );
  }

  Container singleStraightLine() {
    return Container(
      height: 1,
      decoration: const BoxDecoration(
          border:
              Border(top: BorderSide(color: Color.fromARGB(255, 99, 99, 99)))),
    );
  }
}
