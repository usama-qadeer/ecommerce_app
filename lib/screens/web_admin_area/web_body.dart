import 'package:ecommerce_app/screens/web_admin_area/addProducts_screen.dart';
import 'package:ecommerce_app/screens/web_admin_area/cart_screen.dart';
import 'package:ecommerce_app/screens/web_admin_area/dashboard_screen.dart';
import 'package:ecommerce_app/screens/web_admin_area/deleteProducts_screen.dart';
import 'package:ecommerce_app/screens/web_admin_area/updateProducts.dart';
import 'package:flutter/material.dart';

class WebMainScreen extends StatefulWidget {
  // const WebMainScreen({Key? key}) : super(key: key);
  static const String id = "webmain";

  @override
  State<WebMainScreen> createState() => _WebMainScreenState();
}

class _WebMainScreenState extends State<WebMainScreen> {
  Widget selectedSCreen = const DashboardScreen();

  chooseScreens(item) {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const DashboardScreen(),
                    ));
              },
              child: const Text("Dashboard"),
            ),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AddProductScreen(),
                    ));
              },
              child: const Text("Add Product"),
            ),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const UpdateProductScreen(),
                    ));
              },
              child: const Text("Update Product"),
            ),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const DeleteProductScreen(),
                    ));
              },
              child: const Text("Delete Product"),
            ),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CartScreen(),
                    ));
              },
              child: const Text("Cart Item"),
            ),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}
