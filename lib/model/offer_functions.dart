import 'package:cloud_firestore/cloud_firestore.dart';

Stream getOfferProducts() async* {
  final QuerySnapshot querySnapshot = await FirebaseFirestore.instance
      .collection('products')
      .where('category', isEqualTo: 'Offer')
      .get();

  final List<DocumentSnapshot> docs = querySnapshot.docs.reversed.toList();
  yield docs;
}
