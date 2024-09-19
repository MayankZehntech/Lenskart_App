import 'package:flutter/material.dart';

class DashLine extends StatelessWidget {
  const DashLine({
    super.key,
    required this.context,
  });

  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 1,
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(
          (MediaQuery.of(context).size.width / 10).floor(),
          (index) => Container(
            width: 5,
            height: 1,
            color: Colors.grey,
          ),
        ),
      ),
    );
  }
}
