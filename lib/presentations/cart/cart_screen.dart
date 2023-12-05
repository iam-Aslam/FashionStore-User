// ignore_for_file: unused_local_variable

import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fashionstore/presentations/checkout/checkout.dart';
import 'package:fashionstore/provider/cart_provider.dart';
import 'package:fashionstore/widgets/appbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:fashionstore/core/constants.dart';
import 'package:fashionstore/widgets/main_heading_widget.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import '../home/widget/shimmer_widget.dart';
import 'widgets/cart_widget.dart';

ValueNotifier<num> totalPriceNotifier = ValueNotifier(0);
ValueNotifier<num> totalCountNotifier = ValueNotifier(0);

class ScreenCart extends StatefulWidget {
  const ScreenCart({Key? key}) : super(key: key);

  @override
  State<ScreenCart> createState() => _ScreenCartState();
}

class _ScreenCartState extends State<ScreenCart> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int itemCount = 0;

  getTotalPrice() async {
    int totalPrice = 0;
    final String email = FirebaseAuth.instance.currentUser!.email ?? '';
    QuerySnapshot snap = await FirebaseFirestore.instance
        .collection('cart')
        .where('email', isEqualTo: email)
        .get();
    totalPrice = 0;
    if (snap.docs.isNotEmpty) {
      for (var doc in snap.docs) {
        int totalprice = doc.get('totalprice') as int;
        totalPrice += totalprice;
      }
      if (mounted) {
        totalPriceNotifier.value = totalPrice;
      }
    }
    return totalPrice;
  }

  getTotalCount() async {
    final String email = FirebaseAuth.instance.currentUser!.email ?? '';
    QuerySnapshot snap = await FirebaseFirestore.instance
        .collection('cart')
        .where('email', isEqualTo: email)
        .get();
    totalCountNotifier.value = snap.docs.length;
  }

  @override
  void initState() {
    super.initState();
    getTotalPrice();
    getTotalCount();
  }

  bool isNotEmpty = false;
  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    int tPrice = 0;
    String email = FirebaseAuth.instance.currentUser!.email!;
    var size = MediaQuery.of(context).size;
    var height = size.height;
    var width = size.width;
    return SafeArea(
        child: Scaffold(
      key: _scaffoldKey,
      body: Padding(
        padding: const EdgeInsets.only(left: 12.0, top: 12, right: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Appbar(goBack: false),
            khieght10,
            const MainHeading(
              text: 'My Cart',
            ),
            khieght20,
            SizedBox(
              height: height / 1.70,
              child: StreamBuilder<QuerySnapshot>(
                stream: cartProvider.getCartStream(email),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final List<DocumentSnapshot> documents =
                        snapshot.data!.docs;
                    itemCount = documents.length;
                    for (var doc in documents) {
                      int price = doc.get('price');
                      int quantity = doc.get('quantity');
                      tPrice += price * quantity;
                    }
                    totalPriceNotifier.value = tPrice;
                    isNotEmpty = documents.isNotEmpty;
                    return documents.isNotEmpty
                        ? ListView.separated(
                            separatorBuilder: (context, index) => khieght20,
                            itemCount: documents.length,
                            itemBuilder: (context, index) {
                              return CartWidget(
                                id: documents[index].get('id').toString(),
                                productId: documents[index]
                                    .get('productid')
                                    .toString(),
                                price: documents[index].get('price'),
                                totalPrice: documents[index].get('totalprice'),
                                color: documents[index].get('color').toString(),
                                size: documents[index].get('size').toString(),
                                quantity: documents[index].get('quantity'),
                                scaffoldContext: _scaffoldKey.currentContext,
                              );
                            },
                          )
                        : const Center(
                            child: Text('Cart is Empty'),
                          );
                  } else if (snapshot.hasError) {
                    Text('Error: ${snapshot.error}');
                    log(snapshot.error.toString());
                  } else if (snapshot.connectionState ==
                      ConnectionState.waiting) {
                    return const HomeProductShimmerEffect();
                  }
                  return const HomeProductShimmerEffect();
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 5.0, right: 10),
              child: Row(
                children: [
                  ValueListenableBuilder(
                    valueListenable: totalCountNotifier,
                    builder: (context, value, child) {
                      return Text(
                        'Total ($value item):',
                        style: GoogleFonts.roboto(
                          textStyle: const TextStyle(
                            letterSpacing: .5,
                            fontSize: 18,
                            color: Colors.grey,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      );
                    },
                  ),
                  const Spacer(),
                  ValueListenableBuilder(
                    valueListenable: totalPriceNotifier,
                    builder: (context, value, child) {
                      return Text(
                        "₹${NumberFormat.decimalPattern().format(value)}",
                        style: GoogleFonts.roboto(
                          textStyle: const TextStyle(
                            letterSpacing: .5,
                            fontSize: 20,
                            color: Colors.black,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(
                      horizontal: width / 20, vertical: height / 50),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0)),
                  backgroundColor: Colors.black,
                  foregroundColor: Colors.white,
                ),
                onPressed: () async {
                  isNotEmpty
                      ? Navigator.push(
                          context,
                          PageTransition(
                            type: PageTransitionType.bottomToTop,
                            child: CheckoutScreen(
                              totalPrice: (totalPriceNotifier.value).toString(),
                              totalCount: itemCount.toString(),
                            ),
                          ),
                        )
                      : Fluttertoast.showToast(
                          msg: 'Cart is Empty',
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.black,
                          textColor: Colors.white,
                        );
                },
                child: Row(
                  children: [
                    Text(
                      'Proceed to Checkout',
                      style: GoogleFonts.poppins(
                        textStyle: const TextStyle(
                          letterSpacing: .5,
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    const Spacer(),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(5),
                      child: Container(
                        color: Colors.white,
                        child: SizedBox(
                          width: 30,
                          height: 30,
                          child: Image.asset('assets/images/next.jpg'),
                        ),
                      ),
                    )
                  ],
                )),
          ],
        ),
      ),
    ));
  }
}
