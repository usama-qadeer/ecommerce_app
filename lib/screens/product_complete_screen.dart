// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, must_be_immutable, sort_child_properties_last, avoid_unnecessary_containers

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/model/cart_model.dart';
import 'package:ecommerce_app/widget/myButton.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../model/product_model.dart';
import '../widget/mHeader.dart';

class ProductsCompleteScreen extends StatefulWidget {
  String? id;
  ProductsCompleteScreen({
    super.key,
    this.id,
  });

  @override
  State<ProductsCompleteScreen> createState() => _ProductsCompleteScreenState();
}

class _ProductsCompleteScreenState extends State<ProductsCompleteScreen> {
  var newPrice = 0;
  List<ProductModel> showProduct = [];
  getProduct() async {
    await FirebaseFirestore.instance.collection('products').get().then(
      (QuerySnapshot querySnapshot) {
        // print(querySnapshot.docs.length);

        querySnapshot.docs
            .where((element) => element['id'] == widget.id)
            .forEach(
          (doc) {
            if (doc.exists) {
              for (var element in doc['imageUrl']) {
                if (element.isNotEmpty) {
                  setState(
                    () {
                      showProduct.add(
                        ProductModel(
                          id: doc['id'],
                          productTitle: doc['productTitle'],
                          productDesp: doc['productDesp'],
                          productPrice: doc['productPrice'],
                          productDiscount: doc['productDiscount'],
                          imageUrl: doc['imageUrl'],
                        ),
                      );
                    },
                  );
                  // print(doc["brandName"]);
                }
              }
            }
            newPrice = showProduct.first.productPrice!;
          },
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    getProduct();
  }

  addFavourite() async {
    CollectionReference collectionReference =
        FirebaseFirestore.instance.collection("favourite");
    await collectionReference
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('items')
        .add({"pid": showProduct.first.id});
  }

  delFavourite(String id) async {
    CollectionReference collectionReference =
        FirebaseFirestore.instance.collection("favourite");
    await collectionReference
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('items')
        .doc(id)
        .delete();
  }

  int selectedIndex = 0;
  bool? isfavrt = false;
  int count = 1;
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return showProduct.isEmpty
        ? Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.black,
            ),
          )
        : Scaffold(
            appBar: PreferredSize(
                child: myHeader(
                  title: "${showProduct.first.productTitle}",
                ),
                preferredSize: Size.fromHeight(10.h)),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Image.network(
                    showProduct[0].imageUrl![selectedIndex],
                    height: 65.h,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ...List.generate(
                          showProduct[0].imageUrl!.length,
                          (index) => InkWell(
                            onTap: () {
                              setState(() {
                                selectedIndex = index;
                              });
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                height: 10.h,
                                width: 10.w,
                                decoration: BoxDecoration(
                                  border: Border.all(),
                                ),
                                child: Image.network(
                                  showProduct[0].imageUrl![index],
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection('favourite')
                          .doc(FirebaseAuth.instance.currentUser!.uid)
                          .collection("items")
                          .where("pid", isEqualTo: showProduct.first.id)
                          .snapshots(),
                      builder:
                          (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (snapshot.data == null) {
                          return CircularProgressIndicator(
                            color: Colors.black,
                          );
                        }
                        return IconButton(
                          onPressed: () {
                            snapshot.data!.docs.length == 0
                                ? addFavourite()
                                : delFavourite(snapshot.data!.docs.first.id);
                          },
                          icon: Icon(Icons.favorite_sharp),
                          color: snapshot.data!.docs.length == 0
                              ? Colors.black
                              : Colors.red,
                        );
                      }),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Container(
                      height: 5.h,
                      width: 15.w,
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(20
                            // topLeft: Radius.circular(20),
                            // topRight: Radius.circular(20),
                            ),
                      ),
                      child: Center(
                        child: Text(
                          "Rs:${showProduct.first.productPrice.toString()}",
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 1.h,
                  ),
                  Container(
                    constraints: BoxConstraints(
                      minHeight: 25.h,
                      minWidth: double.infinity,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Text(
                        showProduct.first.productDesp!,
                        style: TextStyle(fontSize: 16),
                        textAlign: TextAlign.justify,
                      ),
                    ),
                  ),
                  Container(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                          "Note : Discount price Rs ${showProduct.first.productDiscount} will be applied when you order more than 3 orders of this product"),
                    ),
                  ),
                  Container(
                    child: Row(
                      children: [
                        IconButton(
                            onPressed: () {
                              setState(() {
                                if (count > 1) {
                                  count--;
                                  if (count > 3) {
                                    newPrice = count *
                                        showProduct.first.productDiscount!;
                                  } else {
                                    newPrice =
                                        count * showProduct.first.productPrice!;
                                  }
                                }
                              });
                            },
                            icon: Icon(Icons.exposure_minus_1)),
                        Text(
                          "$count",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        IconButton(
                            onPressed: () {
                              setState(() {
                                count++;
                                if (count > 3) {
                                  newPrice = count *
                                      showProduct.first.productDiscount!;
                                } else {
                                  newPrice =
                                      count * showProduct.first.productPrice!;
                                }
                              });
                            },
                            icon: Icon(Icons.exposure_plus_1)),
                        Align(
                          alignment: Alignment.centerRight,
                          child: Container(
                            height: 5.h,
                            width: 15.w,
                            decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(20
                                  // topLeft: Radius.circular(20),
                                  // topRight: Radius.circular(20),
                                  ),
                            ),
                            child: Center(
                              child: Text(
                                "Rs $newPrice",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 16),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Container(
                  //   height: 5.h,
                  //   width: double.infinity,
                  //   decoration: BoxDecoration(
                  //     color: Colors.black,
                  //     // borderRadius: BorderRadius.circular(20
                  //     //     // topLeft: Radius.circular(20),
                  //     //     // topRight: Radius.circular(20),
                  //     //     ),
                  //   ),
                  //   child: Center(
                  //     child: Text(
                  //       "Add to cart",
                  //       style: TextStyle(color: Colors.white, fontSize: 16),
                  //     ),
                  //   ),
                  // ),

                  MyButton(
                    onPress: () {
                      isLoading = true;
                      Cart.addtoCart(Cart(
                        id: showProduct.first.id,
                        name: showProduct.first.productTitle,
                        images: showProduct.first.imageUrl!.first,
                        price: newPrice,
                        quantity: count,
                      )).whenComplete(() {
                        setState(() {
                          isLoading = false;
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text("Add to cart successfully ")));
                        });
                      });
                    },
                    buttonText: "Add to Cart",
                    isLogin: true,
                    isLoading: isLoading,
                  ),

                  SizedBox(
                    height: 100,
                  )
                ],
              ),
            ),
          );
  }
}
