//products section
import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
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
      Fluttertoast.showToast(
        msg: 'Added to wishlist',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black,
        textColor: Colors.white,
      );
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
      Fluttertoast.showToast(
        msg: 'Removed from wishlist',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black,
        textColor: Colors.white,
      );
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
  itemRef.delete().then((_) {
    log('Item removed successfully');
    Fluttertoast.showToast(
      msg: 'Removed From Wishlist',
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.black,
      textColor: Colors.white,
    );
  }).catchError((error) {
    log('Error removing item: $error');
  });
}

void deleteCartItems(String currentUserEmail) async {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  CollectionReference cartCollection = firestore.collection('cart');

  QuerySnapshot cartSnapshot =
      await cartCollection.where('email', isEqualTo: currentUserEmail).get();

  List<QueryDocumentSnapshot> cartDocuments = cartSnapshot.docs;

  WriteBatch batch = firestore.batch();

  for (var cartDoc in cartDocuments) {
    batch.delete(cartDoc.reference);
  }
  log('succesfully deleted');
  await batch.commit();
}

void placeOrderAndDeleteCartItems(String currentUserEmail) async {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  CollectionReference cartCollection = firestore.collection('cart');
  CollectionReference orderCollection = firestore.collection('orders');

  QuerySnapshot cartSnapshot =
      await cartCollection.where('email', isEqualTo: currentUserEmail).get();

  List<QueryDocumentSnapshot> cartDocuments = cartSnapshot.docs;

  WriteBatch batch = firestore.batch();

  for (var cartDoc in cartDocuments) {
    Map<String, dynamic> cartItemData = cartDoc.data() as Map<String, dynamic>;
    // Set active field as true in the order document
    cartItemData['active'] = true;
    DocumentReference orderDocRef = orderCollection.doc();
    cartItemData['orderId'] = orderDocRef.id;
    batch.set(orderDocRef, cartItemData);
    batch.delete(cartDoc.reference);
  }
  log('succesfull');
  await batch.commit();
}
