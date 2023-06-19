// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fashionstore/model/functions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/constants.dart';

class WishlistProductWidget extends StatefulWidget {
  const WishlistProductWidget({
    Key? key,
    required this.id,
    required this.productId,
  }) : super(key: key);
  final String id;
  final String productId;

  @override
  State<WishlistProductWidget> createState() => _WishlistProductWidgetState();
}

class _WishlistProductWidgetState extends State<WishlistProductWidget> {
  String? name;
  String? subName;
  List<String>? imageList;
  int price = 0;
  String? id;

  @override
  void initState() {
    super.initState();
    getProductData(widget.productId).listen((DocumentSnapshot productData) {
      if (productData.exists) {
        setState(() {
          id = productData.get('id');
          name = productData.get('name');
          subName = productData.get('subname');
          price = productData.get('price') ?? 199;

          imageList = List<String>.from(productData.get('image') ??
              [
                'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRfOibKCmQ1BzQ-QSNFLWlcp8BziFRksHSBrw&usqp=CAU'
              ]);
        });
      }
    }, onError: (error) {
      log('Error retrieving product data: $error');
    });
  }

  @override
  Widget build(BuildContext context) {
    //  var size = MediaQuery.of(context).size;
    // var height = size.height;
    // var width = size.width;
    return Material(
      elevation: 12,
      borderRadius: const BorderRadius.all(Radius.circular(20)),
      child: Container(
        height: 100,
        width: 360,
        decoration: const BoxDecoration(
          //color: Colors.amber,
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        child: Row(
          children: [
            kwidth10,
            Container(
              width: 90,
              height: 70,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                  image: NetworkImage(imageList != null && imageList!.isNotEmpty
                      ? imageList![0]
                      : 'https://www.shutterstock.com/image-vector/new-product-260nw-457942297.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            kwidth10,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                khieght20,
                Text(
                  name ?? 'Product Name',
                  style: GoogleFonts.roboto(
                    textStyle: const TextStyle(
                        letterSpacing: .5,
                        fontSize: 15,
                        color: Colors.black,
                        fontWeight: FontWeight.w700),
                  ),
                ),
                khieght5,
                SizedBox(
                  width: 200,
                  child: Text(
                    subName ?? 'Data Unavailable',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.roboto(
                      textStyle: const TextStyle(
                          letterSpacing: .5,
                          fontSize: 12,
                          color: Colors.black54,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                ),
                khieght5,
                Text(
                  '₹ $price',
                  style: GoogleFonts.roboto(
                    textStyle: const TextStyle(
                        letterSpacing: .5,
                        fontSize: 15,
                        color: Colors.black,
                        fontWeight: FontWeight.w700),
                  ),
                ),
              ],
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.only(right: 10.0, bottom: 1, top: 2),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  IconButton(
                      onPressed: () {
                        deleteWishlist(widget.id, context);
                      },
                      icon: const Icon(
                        CupertinoIcons.heart_slash_fill,
                        color: Colors.black,
                      )),
                  // IconButton(
                  //     onPressed: () {},
                  //     icon: const Icon(
                  //       CupertinoIcons.cart_fill_badge_plus,
                  //       color: Colors.black,
                  //     ))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
