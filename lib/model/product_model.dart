import 'package:cloud_firestore/cloud_firestore.dart';

class ProductModel {
  String? category;
  String? id;
  String? productTitle;
  String? productDesp;
  int? productPrice;
  int? productDiscount;
  String? srialCode;
  String? brandName;
  List<dynamic>? imageUrl;
  bool? isFav;
  bool? onSale;
  bool? isPopular;

  ProductModel({
    this.category,
    this.id,
    this.productTitle,
    this.productDesp,
    this.productPrice,
    this.productDiscount,
    this.srialCode,
    this.brandName,
    this.imageUrl,
    this.isFav,
    this.onSale,
    this.isPopular,
  });

  static Future<void> addProduct(ProductModel productModel) async {
    CollectionReference db = FirebaseFirestore.instance.collection("products");
    Map<String, dynamic> data = {
      "category": productModel.category,
      "id": productModel.id,
      "productTitle": productModel.productTitle,
      "productDesp": productModel.productDesp,
      "productPrice": productModel.productPrice,
      "productDiscount": productModel.productDiscount,
      "srialCode": productModel.srialCode,
      "brandName": productModel.brandName,
      "imageUrl": productModel.imageUrl,
      "isPopular": productModel.isPopular,
      "onSale": productModel.onSale,
      "isFav": productModel.isFav,
    };
    await db.add(data);
  }

  static Future<void> updateProduct(
      String id, ProductModel updateProductModel) async {
    CollectionReference db = FirebaseFirestore.instance.collection("products");

    Map<String, dynamic> data = {
      "category": updateProductModel.category,
      "id": updateProductModel.id,
      "productTitle": updateProductModel.productTitle,
      "productDesp": updateProductModel.productDesp,
      "productPrice": updateProductModel.productPrice,
      "productDiscount": updateProductModel.productDiscount,
      "srialCode": updateProductModel.srialCode,
      "brandName": updateProductModel.brandName,
      "imageUrl": updateProductModel.imageUrl,
      "isPopular": updateProductModel.isPopular,
      "onSale": updateProductModel.onSale,
      "isFav": updateProductModel.isFav,
    };
    await db.doc(id).update(data);
  }

  static Future<void> deleteProduct(String id) async {
    CollectionReference db = FirebaseFirestore.instance.collection("products");

    await db.doc(id).delete();
  }
}
