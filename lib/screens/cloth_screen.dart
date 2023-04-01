import 'package:ecommerce_app/utitlies/style.dart';
import 'package:flutter/material.dart';

class ClothScreen extends StatelessWidget {
  const ClothScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        "This is a Cloth Page....",
        style: BoldStyle.boldStyle,
      ),
    );
  }
}
