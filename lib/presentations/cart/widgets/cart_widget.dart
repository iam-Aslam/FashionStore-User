import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fashionstore/core/constants.dart';
import 'package:fashionstore/model/functions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';

class CartWidget extends StatefulWidget {
  final String id;
  final String productId;
  final String color;
  final String size;
  final int price;
  final int totalPrice;
  final int quantity;

  const CartWidget({
    Key? key,
    required this.id,
    required this.productId,
    required this.color,
    required this.size,
    required this.price,
    required this.totalPrice,
    required this.quantity,
  }) : super(key: key);

  @override
  State<CartWidget> createState() => _CartWidgetState();
}

class _CartWidgetState extends State<CartWidget> {
  String? name;
  String? subName;
  List<String>? imageList;
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
    var size = MediaQuery.of(context).size;

    return Slidable(
      endActionPane: ActionPane(
        motion: const StretchMotion(),
        extentRatio: 0.15,
        children: [
          SlidableAction(
              borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(20),
                  bottomRight: Radius.circular(20)),
              onPressed: (context) {
                // deleteCart(id!, context);
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('Delete confirmation'),
                      content: const Text(
                          'Are you sure you want to delete this item?'),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop(false);
                          },
                          child: const Text(
                            'Cancel',
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop(true);
                          },
                          child: const Text(
                            'Delete',
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                      ],
                    );
                  },
                ).then((value) {
                  if (value != null && value) {
                    deleteCart(id!, context);
                  }
                });
              },
              backgroundColor: Colors.black,
              foregroundColor: Colors.white,
              icon: Icons.delete_rounded),
        ],
      ),
      child: Material(
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
                height: 80,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                      image: NetworkImage(imageList != null &&
                              imageList!.isNotEmpty
                          ? imageList![0]
                          : 'https://www.shutterstock.com/image-vector/new-product-260nw-457942297.jpg'),
                      fit: BoxFit.cover,
                    )),
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
                  Text(
                    subName ?? 'Data Unavailable',
                    style: GoogleFonts.roboto(
                      textStyle: const TextStyle(
                          letterSpacing: .5,
                          fontSize: 12,
                          color: Colors.black54,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                  Row(
                    children: [
                      Column(
                        children: [
                          khieght20,
                          SizedBox(
                            width: 80,
                            child: Text(
                              '₹ ${widget.price}',
                              style: GoogleFonts.roboto(
                                textStyle: const TextStyle(
                                    letterSpacing: .5,
                                    fontSize: 15,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w700),
                              ),
                            ),
                          ),
                        ],
                      ),
                      kwidth80,
                      Container(
                          height: 30,
                          decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius: BorderRadius.circular(30)),
                          child: SizedBox(
                            width: size.width * 0.2,
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                GestureDetector(
                                  onTap: () async {
                                    log('Reduce count');
                                  },
                                  child: const Icon(
                                    CupertinoIcons.minus,
                                    size: 15,
                                  ),
                                ),
                                const Text(
                                  '1',
                                  style: TextStyle(fontSize: 20),
                                ),
                                GestureDetector(
                                  onTap: () async {
                                    log('Add count');
                                  },
                                  child: const Icon(
                                    CupertinoIcons.add,
                                    size: 15,
                                  ),
                                ),
                              ],
                            ),
                          ))
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
