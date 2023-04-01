// ignore_for_file: sort_child_properties_last, avoid_unnecessary_containers

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../widget/mHeader.dart';

class CartScreen extends StatelessWidget {
  CartScreen({super.key});
  CollectionReference db = FirebaseFirestore.instance.collection("cart");
  deleteTocart(String id, BuildContext context) {
    db.doc(id).delete().then((value) => ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text("Delete item "))));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          child: myHeader(
            title: "Cart Item",
          ),
          preferredSize: Size.fromHeight(10.h)),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('cart').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.black,
                backgroundColor: Colors.red,
              ),
            );
          }
          return Container(
            child: ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (BuildContext context, int index) {
                final res = snapshot.data!.docs[index];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(),
                        borderRadius: const BorderRadius.only(
                            topRight: Radius.circular(10),
                            bottomRight: Radius.circular(10)),
                        boxShadow: const [
                          BoxShadow(
                              color: Colors.grey,
                              blurRadius: 3,
                              spreadRadius: 3,
                              offset: Offset(3, 3))
                        ]),
                    // width: double.infinity,
                    child: Row(
                      children: [
                        Image.network(
                          res['images'],
                          height: 90,
                          width: 90,
                          fit: BoxFit.cover,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(res['productName']),
                              Row(
                                children: [
                                  Row(
                                    children: [
                                      const Text("Qty "),
                                      Container(
                                        //   alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                            color: Colors.black,
                                            borderRadius:
                                                BorderRadius.circular(20)),
                                        // ignore: prefer_const_constructors
                                        constraints: BoxConstraints(
                                          minHeight: 20,
                                          minWidth: 50,
                                          maxHeight: 20,
                                          maxWidth: 50,
                                        ),
                                        child: Center(
                                          child: Text(
                                            "${res['quantity']}",
                                            style: const TextStyle(
                                                color: Colors.white),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Row(
                                    children: [
                                      const Text("Price  "),
                                      Center(
                                        child: Text(
                                          "${res['price']}",
                                          style: const TextStyle(
                                              color: Colors.black),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: InkWell(
                            onTap: () {
                              deleteTocart(res.id, context);
                            },
                            child: const CircleAvatar(
                              backgroundColor: Colors.red,
                              radius: 10,
                              child: Icon(
                                Icons.remove,
                                color: Colors.white,
                                size: 10,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
