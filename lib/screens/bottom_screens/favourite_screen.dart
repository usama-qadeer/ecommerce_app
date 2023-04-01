// ignore_for_file: sort_child_properties_last, avoid_unnecessary_containers, prefer_const_constructors_in_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/screens/bottom_screens/products_screen.dart';
import 'package:ecommerce_app/screens/product_complete_screen.dart';
import 'package:ecommerce_app/widget/mHeader.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class FavouriteScreen extends StatefulWidget {
  FavouriteScreen({
    super.key,
  });

  @override
  State<FavouriteScreen> createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavouriteScreen> {
  List ids = [];
  getid() async {
    FirebaseFirestore.instance
        .collection('favourite')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('items')
        .get()
        .then((QuerySnapshot<Map<String, dynamic>> snapshot) {
      snapshot.docs.forEach((element) {
        setState(() {
          ids.add(element["pid"]);
          // print(ids);
          // print(element["pid"]);
        });
      });
    });
  }

  @override
  void initState() {
    super.initState();
    getid();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          child: myHeader(title: "Favourite"),
          preferredSize: Size.fromHeight(5.h)),
      body: Center(
        child: StreamBuilder(
          stream: FirebaseFirestore.instance.collection("products").snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return const CircularProgressIndicator(
                color: Colors.black,
                backgroundColor: Colors.redAccent,
              );
            }
            if (snapshot.data == null) {
              return const Text("NO PRODUCT FOUND");
            }
            List<QueryDocumentSnapshot<Object?>> fp = snapshot.data!.docs
                .where((element) => ids.contains(element['id']))
                .toList();
            return Container(
              child: ListView.builder(
                itemCount: fp.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ProductsCompleteScreen(
                              id: fp[index]['id'],
                            ),
                          ));
                    },
                    child: Card(
                      color: Colors.black,
                      child: ListTile(
                        title: Text(
                          fp[index]['productTitle'],
                          style: const TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        trailing: IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.navigate_next,
                              color: Colors.white,
                            )),
                      ),
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
