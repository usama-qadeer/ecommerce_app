import 'package:ecommerce_app/utitlies/style.dart';
import 'package:flutter/material.dart';

class GroceryScreen extends StatelessWidget {
  const GroceryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text(
          "This is a Grocery Page....",
          style: BoldStyle.boldStyle,
        ),
      ),
    );
  }
}
