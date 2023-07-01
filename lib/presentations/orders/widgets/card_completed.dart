// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fashionstore/model/functions.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fashionstore/core/constants.dart';

class CardCompleted extends StatefulWidget {
  const CardCompleted({
    Key? key,
    required this.productId,
    required this.totalPrice,
  }) : super(key: key);
  final String productId;
  final int totalPrice;

  @override
  State<CardCompleted> createState() => _CardCompletedState();
}

class _CardCompletedState extends State<CardCompleted> {
  String? name;
  String? subName;
  List<String>? imageList;
  @override
  void initState() {
    getProductData(widget.productId).listen((DocumentSnapshot productData) {
      if (productData.exists) {
        setState(() {
          name = productData.get('name');
          subName = productData.get('subname');
          imageList = List<String>.from(productData.get('image') ??
              [
                'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRfOibKCmQ1BzQ-QSNFLWlcp8BziFRksHSBrw&usqp=CAU'
              ]);
        });
      }
    }, onError: (error) {
      log('Error retrieving product data: $error');
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 12,
      borderRadius: const BorderRadius.all(Radius.circular(20)),
      child: Container(
        height: 100,
        width: 360,
        decoration: const BoxDecoration(
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
                  '₹ ${widget.totalPrice}',
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
          ],
        ),
      ),
    );
  }
}
