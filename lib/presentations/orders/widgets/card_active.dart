import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fashionstore/core/constants.dart';
import 'package:fashionstore/model/functions.dart';
import 'order_cancel.dart';

class CardActive extends StatefulWidget {
  const CardActive({
    Key? key,
    required this.productId,
    required this.totalPrice,
    required this.orderId,
  }) : super(key: key);

  final String productId;
  final int totalPrice;
  final String orderId;
  @override
  State<CardActive> createState() => _CardActiveState();
}

class _CardActiveState extends State<CardActive> {
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
        //width: size.width / 2,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        child: Row(
          children: [
            kwidth10,
            Container(
              width: 70,
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
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 0, top: 16),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: GestureDetector(
                      onTap: () async {
                        orderCancelConfirm(context, widget.orderId);
                      },
                      child: const Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                        child: Text(
                          'Cancel',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
