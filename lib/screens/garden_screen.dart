import 'package:ecommerce_app/utitlies/style.dart';
import 'package:flutter/material.dart';

class GardenScreen extends StatelessWidget {
  const GardenScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text(
          "This is a Garden Page....",
          style: BoldStyle.boldStyle,
        ),
      ),
    );
  }
}
