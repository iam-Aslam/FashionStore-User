//products section

import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fashionstore/widgets/snackbar.dart';
import 'package:flutter/material.dart';
import 'cart_model.dart';
import 'product_models.dart';

Stream getProducts() async* {
  final QuerySnapshot querySnapshot =
      await FirebaseFirestore.instance.collection('products').get();
  final List<DocumentSnapshot> docs = querySnapshot.docs.toList();
  yield docs;
}

List<Products> convertToProductsList(List<DocumentSnapshot> documents) {
  return documents.map((snapshot) {
    return Products.fromJson(snapshot.data() as Map<String, dynamic>);
  }).toList();
}

//add to cart function
Future<void> addToCart(Cart cartModel, BuildContext context) async {
  final cart = FirebaseFirestore.instance.collection('cart');

  final reference = cart.doc();
  try {
    alertSnackbar(context, "Added to cart");
    await reference.set({
      'productid': cartModel.productId,
      'id': reference.id,
      'color': cartModel.color,
      'quantity': cartModel.quantity,
      'price': cartModel.price,
      'totalprice': cartModel.totalPrice,
      'email': cartModel.email,
      'size': cartModel.size,
    }).then((value) => Navigator.pop(context));
    log("Added to cart");
  } catch (error) {
    alertSnackbar(context, "Failed to add product to cart: $error");
    log("Failed to add product to cart: $error");
  }
}
