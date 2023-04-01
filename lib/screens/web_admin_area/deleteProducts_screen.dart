import 'package:ecommerce_app/utitlies/style.dart';
import 'package:flutter/material.dart';

class DeleteProductScreen extends StatelessWidget {
  const DeleteProductScreen({super.key});

  static const String id = "deleteproduct";

  @override
  Widget build(BuildContext context) {
    return const Center(
        child: Text(
      "Delete Products",
      style: BoldStyle.boldStyle,
    ));
  }
}
