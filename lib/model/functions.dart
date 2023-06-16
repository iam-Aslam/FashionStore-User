//products section

import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fashionstore/widgets/snackbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
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

//get cart products
Stream<List<DocumentSnapshot>> getCart(String emailId) async* {
  final QuerySnapshot querySnapshot = await FirebaseFirestore.instance
      .collection('cart')
      .where('email', isEqualTo: emailId)
      .get();
  final List<DocumentSnapshot> docs = querySnapshot.docs.toList();
  yield docs;
}

//get product data
Stream<DocumentSnapshot> getProductData(String productId) {
  final CollectionReference productsCollection =
      FirebaseFirestore.instance.collection('products');

  return productsCollection.doc(productId).snapshots();
}

//delete cart product
Future<void> deleteCart(String id, BuildContext context) {
  CollectionReference cartProduct =
      FirebaseFirestore.instance.collection('cart');
  return cartProduct.doc(id).delete().then((value) {
    log("Cart Deleted");
    alertSnackbar(context, "Product was deleted");
  }).catchError((error) {
    log("Failed to delete Cart: $error");
    alertSnackbar(context, "Failed to delete Cart Item");
  });
}

//update Quantity of product
Future<void> updateCartQuantity(
    int quantity, num totalPrice, String id, int productQuantity) async {
  final users = FirebaseFirestore.instance.collection('users');
  final String email = FirebaseAuth.instance.currentUser!.email!;
  final reference = users.doc(email).collection('cart').doc(id);
  try {
    if (quantity <= productQuantity) {
      await reference.update({
        'quantity': quantity,
        'totalPrice': totalPrice,
      });
      log("Updated cart quantity");
    } else {
      log("Only $productQuantity products are available");
    }
  } catch (error) {
    log("Failed to update address: $error");
  }
}
