import 'package:flutter/material.dart';

class DashLine extends StatelessWidget {
  const DashLine({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(left: 30, right: 30),
      child: Row(
        children: [
          Expanded(
            child: Divider(
              color: Color.fromARGB(255, 199, 199, 199),
              thickness: 1,
              indent: 8,
              endIndent: 8,
            ),
          ),
          Text(
            "OR",
            style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.normal,
                color: Colors.black,
                fontFamily: 'poppins'),
          ),
          Expanded(
            child: Divider(
              color: Color.fromARGB(255, 199, 199, 199),
              thickness: 1,
              indent: 8,
              endIndent: 8,
            ),
          ),
        ],
      ),
    );
  }
}
