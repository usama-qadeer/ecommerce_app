import 'package:ecommerce_app/screens/loading_screen.dart';
import 'package:ecommerce_app/screens/web_admin_area/web_login_screen.dart';
import 'package:flutter/material.dart';

class LayoutScreen extends StatelessWidget {
  const LayoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.minWidth > 600) {
          return WebLoginScreen();
        } else {
          return LoadingScreen();
        }
      },
    );
  }
}
