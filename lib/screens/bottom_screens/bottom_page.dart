// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/screens/bottom_screens/favourite_screen.dart';
import 'package:ecommerce_app/screens/bottom_screens/products_screen.dart';
import 'package:ecommerce_app/screens/bottom_screens/profile_screen.dart';
import 'package:ecommerce_app/screens/home_screen.dart';
import 'package:ecommerce_app/screens/web_admin_area/cart_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BottomPage extends StatefulWidget {
  BottomPage({super.key});

  @override
  State<BottomPage> createState() => _BottomPageState();
}

class _BottomPageState extends State<BottomPage> {
  int length = 0;
  void cartItems() {
    FirebaseFirestore.instance.collection("cart").get().then((snap) {
      if (snap.docs.isNotEmpty) {
        setState(() {
          length = snap.docs.length;
        });
      } else {
        setState(() {
          length = snap.docs.length;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    cartItems();
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(items: [
        BottomNavigationBarItem(icon: Icon(Icons.home)),
        BottomNavigationBarItem(icon: Icon(Icons.shop_rounded)),
        BottomNavigationBarItem(
          icon: Stack(
            children: [
              Icon(Icons.shopping_cart),
              Positioned(
                top: 1,
                right: 1,
                child: length == 0
                    ? Container()
                    : Stack(
                        children: [
                          Icon(
                            Icons.brightness_1,
                            color: Colors.green,
                            size: 20,
                          ),
                          Positioned.fill(
                              child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              "$length",
                              style: TextStyle(color: Colors.white),
                            ),
                          ))
                        ],
                      ),
              ),
            ],
          ),
        ),
        BottomNavigationBarItem(icon: Icon(Icons.favorite)),
        BottomNavigationBarItem(icon: Icon(Icons.person)),
      ]),
      tabBuilder: (context, index) {
        switch (index) {
          case 0:
            return CupertinoTabView(
              builder: (context) {
                return CupertinoPageScaffold(child: HomeScreen());
              },
            );
          case 1:
            return CupertinoTabView(
              builder: (context) {
                return CupertinoPageScaffold(child: ProductScreen());
              },
            );
          case 2:
            return CupertinoTabView(
              builder: (context) {
                return CupertinoPageScaffold(child: CartScreen());
              },
            );
          case 3:
            return CupertinoTabView(
              builder: (context) {
                return CupertinoPageScaffold(child: FavouriteScreen());
              },
            );
          case 4:
            return CupertinoTabView(
              builder: (context) {
                return CupertinoPageScaffold(child: ProfileScreen());
              },
            );

          default:
        }
        return HomeScreen();
      },
    );
  }
}
