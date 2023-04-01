// ignore_for_file: avoid_function_literals_in_foreach_calls, avoid_print, avoid_unnecessary_containers, sized_box_for_whitespace, prefer_const_constructors

import 'dart:math';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/model/product_model.dart';
import 'package:ecommerce_app/widget/category_box.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

final List images = [
  "https://images.pexels.com/photos/3965548/pexels-photo-3965548.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
  "https://images.pexels.com/photos/3951790/pexels-photo-3951790.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
  "https://images.pexels.com/photos/626986/pexels-photo-626986.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
  "https://images.pexels.com/photos/3965548/pexels-photo-3965548.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
  "https://images.pexels.com/photos/3951790/pexels-photo-3951790.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
  "https://images.pexels.com/photos/626986/pexels-photo-626986.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
];
// List category = [
//   "GROCERY",
//   "ELECTRONIC",
//   "CLOTHS",
//   "GARDEN",
//   "HOUSE",
//   "PHARMACY",
// ];

class _HomeScreenState extends State<HomeScreen> {
  List<ProductModel> showProduct = [];

  getProduct() async {
    await FirebaseFirestore.instance
        .collection('products')
        .get()
        .then((QuerySnapshot querySnapshot) {
      print(querySnapshot.docs.length);

      querySnapshot.docs.forEach((doc) {
        if (querySnapshot.docs.isNotEmpty) {
          setState(() {
            showProduct.add(ProductModel(
              category: doc['category'],
              // id: id,
              productTitle: doc['productTitle'],
              productDesp: doc['productDesp'],
              productPrice: doc['productPrice'],
              productDiscount: doc['productDiscount'],
              srialCode: doc['srialCode'],
              brandName: doc['brandName'],
              imageUrl: doc['imageUrl'],
              isFav: doc['isFav'],
              onSale: doc['onSale'],
              isPopular: doc['isPopular'],
            ));
          });
          // print(doc["brandName"]);
        }
      });
    });
  }

  @override
  void initState() {
    // myFun();
    super.initState();
    getProduct();
  }

  @override
  Widget build(BuildContext context) {
    // getData();
    // print(showProduct.first.brandName);

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 2.h),
              child: Container(
                child: RichText(
                  text: const TextSpan(
                    text: "Online Bazar",
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.deepPurple,
                    ),
                  ),
                ),
              ),
            ),
            CategoryBox(),
            CarouselSlider(
              items: images
                  .map(
                    (e) => Stack(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.network(
                              e,
                              width: double.infinity,
                              height: 250,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            // width: double.infinity,
                            height: 250,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              gradient: LinearGradient(
                                colors: [
                                  Colors.redAccent.withOpacity(0.3),
                                  Colors.blueAccent.withOpacity(0.3),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 20,
                          left: 20,
                          child: Container(
                            //    width: 100,
                            color: Colors.black.withOpacity(0.4),
                            child: Text(
                              "TITLE",
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.white.withOpacity(0.5),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                  .toList(),
              options: CarouselOptions(
                height: 250,
                autoPlay: true,
                autoPlayAnimationDuration: const Duration(seconds: 3),
              ),
            ),
            Text(
              "Popular items".toUpperCase(),
              style: TextStyle(fontSize: 22),
            ),
            // Text(showProduc.toString()),
            // showProduct.length == 0
            //     ? CircularProgressIndicator()
            Container(
              height: 30.h,
              child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: showProduct
                      .where((element) => element.isPopular == true)
                      .map((e) => Padding(
                            padding: const EdgeInsets.fromLTRB(10, 05, 10, 05),
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.black),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Column(
                                children: [
                                  Container(
                                    height: 80,
                                    width: 80,
                                    child: Image.network(
                                      e.imageUrl![0],
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                  Text(e.productTitle!),
                                  Text("Rs: ${e.productPrice.toString()}"),
                                  Text("Discount Price: ${e.productDiscount}"),
                                  Text(
                                    "See More",
                                    style: TextStyle(
                                      color: Colors.blue,
                                    ),
                                    //textAlign: TextAlign.end,
                                  )
                                ],
                              ),
                            ),
                          ))
                      .toList()),
            ),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(color: Colors.green.shade200),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(
                          child: Text(
                            "Hot Sales",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(color: Colors.redAccent),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(
                          child: Text(
                            "New Arival",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            /*TOP BRANDS */
            Text(
              "top brand".toUpperCase(),
              style: TextStyle(fontSize: 22),
            ),

            Container(
              // alignment: Alignment.center,
              height: 10.h,
              child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: showProduct
                      .map((e) => Padding(
                            padding: const EdgeInsets.fromLTRB(10, 05, 10, 05),
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.black),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.primaries[
                                      Random().nextInt(showProduct.length)],
                                  border: Border.all(color: Colors.black),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                //  height: 20,
                                width: 50,
                                child: Center(
                                  child: Text(
                                    e.brandName![0],
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ))
                      .toList()),
            ),

/*TOP BRANDS END */
          ],
        ),
      ),
    );
  }
}
