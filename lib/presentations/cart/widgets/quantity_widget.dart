// // ignore_for_file: use_build_context_synchronously
// import 'dart:developer';

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:fashionstore/model/functions.dart';
// import 'package:fashionstore/presentations/cart/cart_screen.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';

// ValueNotifier<num> totalPriceNotifier = ValueNotifier(0);

// class QuantityCartWidget extends StatefulWidget {
//   const QuantityCartWidget({
//     super.key,
//     required this.id,
//     // required this.productData,
//     //required this.callback,
//   });

//   final String id;
//   // final dynamic productData;
//   //final VoidCallback callback;

//   void updateParentState() {
//     //callback();
//   }

//   @override
//   State<QuantityCartWidget> createState() => _QuantityCartWidgetState();
// }

// class _QuantityCartWidgetState extends State<QuantityCartWidget> {
//   @override
//   Widget build(BuildContext context) {
//     final email = FirebaseAuth.instance.currentUser!.email;
//     final size = MediaQuery.of(context).size;
//     return Container(
//       height: 30,
//       decoration: BoxDecoration(
//           color: Colors.grey[300], borderRadius: BorderRadius.circular(30)),
//       child: SizedBox(
//           width: size.width * 0.2,
//           child: ValueListenableBuilder(
//             valueListenable: editNotifier,
//             builder: (context, editBool, child) {
//               return FutureBuilder(
//                 future: FirebaseFirestore.instance
//                     .collection('cart')
//                     .where('email', isEqualTo: email)
//                     .get(),

//                 // .doc(email)
//                 // .collection('cart')
//                 // .orderBy('price')
//                 // .get(),
//                 builder: (context, snapshot) {
//                   log(snapshot.toString());
//                   if (snapshot.connectionState == ConnectionState.waiting) {
//                     return const Center();
//                   }
//                   final data = snapshot.data!.docs.toList();

//                   if (data.isEmpty) {
//                     return const Text('empty');
//                   }
//                   int totalPrice = 0;
//                   for (int i = 0; i < data.length; i++) {
//                     totalPrice = data[i]['totalPrice'] + totalPrice;
//                   }
//                   return Row(
//                     mainAxisSize: MainAxisSize.max,
//                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                     children: [
//                       GestureDetector(
//                         onTap: () async {
//                           // int quantity =
//                           //     await data[widget.index]['quantity'] - 1;
//                           // num price = 0;

//                           // if (quantity == 0) {
//                           //   showDeleteConfirmationDialog(
//                           //       context,
//                           //       widget.productData[widget.index]['id'],
//                           //       widget.productData,
//                           //       price);
//                           // } else {
//                           //   setState(() {});
//                           //   if (quantity == 1) {
//                           //     price = await widget.productData[widget.index]
//                           //         ['price'];
//                           //   } else {
//                           //     price = await data[widget.index]['totalPrice'] -
//                           //         widget.productData[widget.index]['price'];
//                           //     totalPriceNotifier.value--;
//                           //   }
//                           //   totalPriceNotifier.value--;
//                           //   await updateCartQuantity(
//                           //       quantity,
//                           //       price,
//                           //       data[widget.index]['id'],
//                           //       widget.productData[widget.index]['quantity']);
//                           //   totalPriceNotifier.value = totalPrice -
//                           //       widget.productData[widget.index]['price'];
//                           // }
//                         },
//                         child: const Icon(
//                           CupertinoIcons.minus,
//                           size: 16,
//                         ),
//                       ),
//                       Padding(
//                           padding: const EdgeInsets.only(top: 5),
//                           child: Text('3')),
//                       GestureDetector(
//                         onTap: () async {
//                           // if (data[widget.index]['quantity'] !=
//                           //     widget.productData[widget.index]['quantity']) {
//                           //   setState(() {});
//                           //   int quantity = data[widget.index]['quantity'] + 1;
//                           //   num price = 0;
//                           //   if (quantity == 1) {
//                           //     price = await widget.productData[widget.index]
//                           //         ['price'];
//                           //   } else {
//                           //     totalPriceNotifier.value++;

//                           //     price = await widget.productData[widget.index]
//                           //             ['price'] +
//                           //         data[widget.index]['totalPrice'];
//                           //   }
//                           //   await updateCartQuantity(
//                           //       quantity,
//                           //       price,
//                           //       data[widget.index]['id'],
//                           //       widget.productData[widget.index]['quantity']);
//                           //   totalPriceNotifier.value = totalPrice +
//                           //       widget.productData[widget.index]['price'];
//                           // } else {
//                           //   // showEmailSentSnackbar(
//                           //   //     context, "Product out of stock");
//                           //   log('Product Out of Stock');
//                           // }
//                         },
//                         child: const Icon(
//                           CupertinoIcons.add,
//                           size: 16,
//                         ),
//                       ),
//                     ],
//                   );
//                 },
//               );
//             },
//           )),
//     );
//   }

//   showDeleteConfirmationDialog(
//       BuildContext context, String documentId, dynamic data, num price) {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: const Text('Delete Confirmation'),
//           content: const Text(
//               'Are you sure you want to delete this product from cart?'),
//           actions: [
//             TextButton(
//               style: ButtonStyle(
//                 foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
//               ),
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//               child: const Text('Cancel'),
//             ),
//             TextButton(
//               style: ButtonStyle(
//                 foregroundColor: MaterialStateProperty.all<Color>(Colors.red),
//               ),
//               onPressed: () async {
//                 // final String email = FirebaseAuth.instance.currentUser!.email!;
//                 // QuerySnapshot querySnapshot = await FirebaseFirestore.instance
//                 //     .collection('users')
//                 //     .doc(email)
//                 //     .collection('cart')
//                 //     .where('productId', isEqualTo: documentId)
//                 //     .get();
//                 //  await deleteFromCart(querySnapshot.docs.first.id);
//                 // setState(() {
//                 //   widget.productData
//                 //       .removeWhere((item) => item['id'] == documentId);
//                 // });
//                 Navigator.pop(context);
//                 super.setState(() {});
//                 setState(() {});
//                 widget.updateParentState();
//               },
//               child: const Text('Delete'),
//             ),
//           ],
//         );
//       },
//     );
//   }
// }
