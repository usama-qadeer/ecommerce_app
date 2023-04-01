// ignore_for_file: sort_child_properties_last, must_be_immutable, avoid_unnecessary_containers

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/screens/product_complete_screen.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../model/product_model.dart';
import '../../widget/mHeader.dart';

class ProductScreen extends StatefulWidget {
  String? categoryy;
  ProductScreen({super.key, this.categoryy});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  List<ProductModel> showProduct = [];
  TextEditingController searchC = TextEditingController();
  getProduct() async {
    await FirebaseFirestore.instance
        .collection('products')
        .get()
        .then((QuerySnapshot querySnapshot) {
      // print(querySnapshot.docs.length);

      if (widget.categoryy == null) {
        querySnapshot.docs.forEach((doc) {
          if (querySnapshot.docs.isNotEmpty) {
            setState(() {
              showProduct.add(ProductModel(
                id: doc['id'],
                productTitle: doc['productTitle'],
                imageUrl: doc['imageUrl'],
              ));
            });
            // print(doc["brandName"]);
          }
        });
      } else {
        querySnapshot.docs
            .where((element) => element['category'] == widget.categoryy)
            .forEach((doc) {
          if (querySnapshot.docs.isNotEmpty) {
            setState(() {
              showProduct.add(ProductModel(
                id: doc['id'],
                productTitle: doc['productTitle'],
                imageUrl: doc['imageUrl'],
              ));
            });
            // print(doc["brandName"]);
          }
        });
      }
    });
  }

  List<ProductModel> totalItem = [];
  filterData(String querry) {
    List<ProductModel> dummySearch = [];
    dummySearch.addAll(showProduct);
    if (querry.isNotEmpty) {
      List<ProductModel> dummyData = [];
      dummySearch.forEach((element) {
        if (element.productTitle!
            .toLowerCase()
            .contains(querry.toLowerCase())) {
          dummyData.add(element);
        }
      });
      setState(() {
        showProduct.clear();
        showProduct.addAll(dummyData);
      });
      return;
    } else {
      setState(() {
        showProduct.clear();

        showProduct.addAll(totalItem);
      });
      return;
    }
  }

  @override
  void initState() {
    // myFun();
    super.initState();
    getProduct();
    Future.delayed(const Duration(seconds: 1), () {
      totalItem.addAll(showProduct);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
            child: myHeader(title: widget.categoryy ?? "All Products"),
            preferredSize: Size.fromHeight(5.h)),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: TextFormField(
                controller: searchC,
                onChanged: (v) {
                  filterData(v);
                },
                decoration: const InputDecoration(
                  hintText: "Search..",
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2),
                itemCount: showProduct.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ProductsCompleteScreen(
                              id: showProduct[index].id,
                            ),
                          ));
                    },
                    child: Container(
                      // height: 10.h,
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Column(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                border: Border.all(),
                              ),
                              child: Image.network(
                                showProduct[index].imageUrl![0],
                                width: 300,
                                height: 200,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Expanded(
                              child: Text(
                                showProduct[index].productTitle!,
                                style: const TextStyle(fontSize: 18),
                                textAlign: TextAlign.center,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ));
  }
}
