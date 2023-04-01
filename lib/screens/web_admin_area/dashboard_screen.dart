import 'package:ecommerce_app/utitlies/style.dart';
import 'package:flutter/material.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  static const String id = "dashboard";

  @override
  Widget build(BuildContext context) {
    return const Center(
        child: Text(
      "Dashboard",
      style: BoldStyle.boldStyle,
    ));
  }
}
