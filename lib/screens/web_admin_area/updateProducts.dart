// ignore_for_file: unnecessary_null_comparison, avoid_unnecessary_containers, sized_box_for_whitespace

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/model/product_model.dart';
import 'package:ecommerce_app/screens/web_admin_area/update_complete_screen.dart';
import 'package:ecommerce_app/utitlies/style.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class UpdateProductScreen extends StatelessWidget {
  const UpdateProductScreen({super.key});

  static const String id = "updateproduct";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        children: [
          const Text(
            "Update Products",
            style: BoldStyle.boldStyle,
          ),
          Container(
            height: 50.h,
            child: StreamBuilder(
              stream:
                  FirebaseFirestore.instance.collection("products").snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (snapshot == null) {
                  return const Text(
                    "NO DATA EXIST",
                    style: TextStyle(fontSize: 40, color: Colors.grey),
                  );
                }
                //  print(snapshot.data!.docs.length.toString());
                return Container(
                  height: 80.h,
                  child: ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: Container(
                          color: Colors.black,
                          child: ListTile(
                            title: Text(
                              snapshot.data!.docs[index]["productTitle"],
                              style: const TextStyle(color: Colors.amber),
                            ),
                            trailing: Container(
                              width: 10.w,
                              child: Row(
                                children: [
                                  IconButton(
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => UpdateProductCompleteScreen(
                                                id: snapshot
                                                    .data!.docs[index].id,
                                                productmodel: ProductModel(
                                                    category: snapshot.data!.docs[index]
                                                        ["category"],
                                                    id: snapshot
                                                        .data!.docs[index].id,
                                                    productTitle:
                                                        snapshot.data!.docs[index]
                                                            ["productTitle"],
                                                    productDesp: snapshot.data!.docs[index]
                                                        ["productDesp"],
                                                    productPrice:
                                                        snapshot.data!.docs[index]
                                                            ["productPrice"],
                                                    productDiscount:
                                                        snapshot.data!.docs[index]
                                                            ["productDiscount"],
                                                    srialCode: snapshot.data!.docs[index]["srialCode"],
                                                    brandName: snapshot.data!.docs[index]["brandName"],
                                                    imageUrl: snapshot.data!.docs[index]["imageUrl"],
                                                    isFav: snapshot.data!.docs[index]["isFav"],
                                                    onSale: snapshot.data!.docs[index]["onSale"],
                                                    isPopular: snapshot.data!.docs[index]["isPopular"])),
                                          ),
                                        );
                                      },
                                      icon: const Icon(
                                        Icons.edit,
                                        color: Colors.white,
                                      )),
                                  IconButton(
                                      onPressed: () {
                                        // Navigator.push(
                                        //   context,
                                        //   MaterialPageRoute(builder: (context) {
                                        //     return Container();
                                        //   }),
                                        // );
                                        ProductModel.deleteProduct(
                                            snapshot.data!.docs[index].id);
                                      },
                                      icon: const Icon(
                                        Icons.delete_forever,
                                        color: Colors.white,
                                      )),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      )),
    );
  }
}
