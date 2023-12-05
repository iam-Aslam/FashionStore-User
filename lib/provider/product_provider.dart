import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ProductProvider extends ChangeNotifier {
  //get product stream
  final Stream<QuerySnapshot> productsStream =
      FirebaseFirestore.instance.collection('products').snapshots();
  //get Category stream
  Stream getCategoryProducts(String category) async* {
    final QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('products')
        .where('category', isEqualTo: category)
        .get();

    final List<DocumentSnapshot> docs = querySnapshot.docs.toList();
    yield docs;
  }

  //get offer stream
  Stream getOfferProducts() async* {
    final QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('products')
        .where('category', isEqualTo: 'Offer')
        .get();

    final List<DocumentSnapshot> docs = querySnapshot.docs.reversed.toList();
    yield docs;
  }
}
