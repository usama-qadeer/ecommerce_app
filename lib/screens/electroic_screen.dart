import 'package:ecommerce_app/utitlies/style.dart';
import 'package:flutter/material.dart';

class ElectronicScreen extends StatelessWidget {
  const ElectronicScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text(
          "This is a Electronic Page....",
          style: BoldStyle.boldStyle,
        ),
      ),
    );
  }
}
