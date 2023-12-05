import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fashionstore/model/cart_model.dart';
import 'package:fashionstore/widgets/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CartProvider with ChangeNotifier {
  int _totalPrice = 0;

  int get totalPrice => _totalPrice;

  void updateTotalPrice(int newTotalPrice) {
    _totalPrice = newTotalPrice;
    notifyListeners();
  }

  //add to cart function
  Future<void> addToCart(Cart cartModel, BuildContext context) async {
    final cart = FirebaseFirestore.instance.collection('cart');

    final reference = cart.doc();
    try {
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
      Fluttertoast.showToast(
        msg: 'Product Added to Cart',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black,
        textColor: Colors.white,
      );
    } catch (error) {
      Fluttertoast.showToast(
        msg: 'Failed to Add to Cart',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black,
        textColor: Colors.white,
      );
      log("Failed to add product to cart: $error");
    }
  }

  //get product stream
  Stream<QuerySnapshot> getCartStream(String email) {
    return FirebaseFirestore.instance
        .collection('cart')
        .where('email', isEqualTo: email)
        .snapshots();
  }

  //delelte cart item
  //delete cart product
  Future<void> deleteCart(String id, BuildContext context) {
    CollectionReference cartProduct =
        FirebaseFirestore.instance.collection('cart');
    return cartProduct.doc(id).delete().then((value) {
      log("Cart Deleted");
      Fluttertoast.showToast(
        msg: 'Removed from Cart',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black,
        textColor: Colors.white,
      );
    }).catchError((error) {
      log("Failed to delete Cart: $error");
      alertSnackbar(context, "Failed to delete Cart Item");
    });
  }
}
