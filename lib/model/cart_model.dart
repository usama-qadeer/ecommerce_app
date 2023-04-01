import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class Cart {
  String? id;
  String? name;
  String? images;
  int? price;
  int? quantity;

  Cart({
    required this.id,
    required this.name,
    required this.images,
    required this.price,
    required this.quantity,
  });

  static Future<void> addtoCart(Cart cart) async {
    CollectionReference db = FirebaseFirestore.instance.collection("cart");
    Map<String, dynamic> data = {
      "id": cart.id,
      "productName": cart.name,
      "images": cart.images,
      "price": cart.price,
      "quantity": cart.quantity,
    };
    db.add(data);
  }
}
