//products section
import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fashionstore/widgets/snackbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'cart_model.dart';
import 'product_models.dart';
import 'wishlist_model.dart';

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
    // Fluttertoast.showToast(
    //   msg: 'Cart Item Removed',
    //   backgroundColor: Colors.grey,
    // );
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

//add to wishlist function
Future<void> addWishlist(Wishlist wishlistModel, BuildContext context) async {
  final wishlist = FirebaseFirestore.instance.collection('wishlist');
  final reference = wishlist.doc();
  try {
    await reference.set({
      'id': reference.id,
      'productid': wishlistModel.productId,
      'email': wishlistModel.email,
    }).then((value) {
      log('Wishlisted');
      alertSnackbar(context, "Item Added To Wishlist");
    });
  } catch (error) {
    log('Failed to add wishlist: $error');
  }
}
//remove from wishlist

Future<void> removeWishlist(
    Wishlist wishlistModel, BuildContext context) async {
  final wishlist = FirebaseFirestore.instance.collection('wishlist');
  try {
    await wishlist
        .where('productid', isEqualTo: wishlistModel.productId)
        .where('email', isEqualTo: wishlistModel.email)
        .get()
        .then((querySnapshot) {
      for (var doc in querySnapshot.docs) {
        doc.reference.delete();
      }
    }).then((value) {
      log('removed from wishlist');
      alertSnackbar(context, "Item Removed From Wishlist");
    });
  } catch (error) {
    log('Failed to remove from wishlist: $error');
  }
}

//check wishlist is added or not
Future<bool> checkIfDocumentExists(String documentId) async {
  final docSnapshot = await FirebaseFirestore.instance
      .collection('wishlist')
      .doc(documentId)
      .get();
  log(docSnapshot.exists.toString());
  return docSnapshot.exists;
}

Future<bool> checkIfProductExistsInWishlist(
    String userEmail, String productId) async {
  try {
    final wishlistSnapshot = await FirebaseFirestore.instance
        .collection('wishlist')
        .where('email', isEqualTo: userEmail)
        .where('productid', isEqualTo: productId)
        .limit(1)
        .get();

    return wishlistSnapshot.docs.isNotEmpty;
  } catch (error) {
    // Handle any potential error, such as network issues or Firestore exceptions
    log('Error checking if product exists in wishlist: $error');
    return false;
  }
}

//delete wishlist
void deleteWishlist(String itemId, BuildContext context) {
  // Get the reference to the document with the specified ID
  DocumentReference itemRef =
      FirebaseFirestore.instance.collection('wishlist').doc(itemId);

  // Delete the document
  itemRef
      .delete()
      .then((_) {
        log('Item removed successfully');
        alertSnackbar(context, "Removed From Wishlist");
      })
      .catchError((error) {})
      .catchError((error) {
        log('Error removing item: $error');
      });
}

//get address function
getAddressDocument() async {
  final email = FirebaseAuth.instance.currentUser;
  try {
    final QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
        .instance
        .collection('address')
        .where('email', isEqualTo: email)
        .get();

    if (snapshot.size > 0) {
      final DocumentSnapshot<Map<String, dynamic>> document = snapshot.docs[0];
      return document;
    }
  } catch (e) {
    log('Error retrieving address document: $e');
  }
  return 0;
}
