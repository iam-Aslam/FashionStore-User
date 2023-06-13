// ignore_for_file: must_be_immutable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fashionstore/core/constants.dart';
import 'package:fashionstore/widgets/main_heading_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../home/widget/Shimmer_widget.dart';
import 'widgets/cart_widget.dart';

class ScreenCart extends StatelessWidget {
  ScreenCart({super.key});
  String email = '';
  Stream<QuerySnapshot> cartStream = const Stream.empty();

  getCartUser() {
    email = FirebaseAuth.instance.currentUser!.email!;
    cartStream = FirebaseFirestore.instance
        .collection('cart')
        .where('email', isEqualTo: email)
        .snapshots();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var height = size.height;
    var width = size.width;
    return SafeArea(
        child: Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 12.0, top: 12, right: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                InkWell(
                  onTap: () {},
                  child: const CircleAvatar(
                      radius: 20,
                      backgroundImage: AssetImage('assets/images/prev.jpg')),
                ),
                const Spacer(),
                IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      CupertinoIcons.bag,
                      size: 30,
                    ))
              ],
            ),
            khieght10,
            MainHeading(
              text: 'My Cart',
            ),
            khieght20,
            StreamBuilder<QuerySnapshot>(
              stream: getCartUser(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final List<DocumentSnapshot> documents = snapshot.data!.docs;
                  return Expanded(
                    child: ListView.separated(
                      separatorBuilder: (context, index) => khieght20,
                      itemCount: documents.length,
                      itemBuilder: (context, index) {
                        return CartWidget(
                          id: documents[index].get('id'),
                          productId: documents[index].get('productid'),
                          price: documents[index].get('price'),
                          totalPrice: documents[index].get('totalprice'),
                          color: documents[index].get('color'),
                          size: documents[index].get('size'),
                          quantity: documents[index].get('quantity'),
                        );
                      },
                    ),
                  );
                } else if (snapshot.hasError) {
                  Text('Error: ${snapshot.error}');
                } else if (snapshot.connectionState ==
                    ConnectionState.waiting) {
                  return const HomeProductShimmerEffect();
                }
                return const Center(
                  child: Text('No Data'),
                );
              },
            ),
            Padding(
              padding: const EdgeInsets.only(left: 5.0, right: 10),
              child: Row(
                children: [
                  Text(
                    'Total (3 item):',
                    style: GoogleFonts.roboto(
                      textStyle: const TextStyle(
                        letterSpacing: .5,
                        fontSize: 18,
                        color: Colors.grey,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                  const Spacer(),
                  Text(
                    '₹ 735',
                    style: GoogleFonts.roboto(
                      textStyle: const TextStyle(
                          letterSpacing: .5,
                          fontSize: 20,
                          color: Colors.black,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                ],
              ),
            ),
            khieght10,
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(
                      horizontal: width / 20, vertical: height / 50),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0)),
                  backgroundColor: Colors.black,
                  foregroundColor: Colors.white,
                ),
                onPressed: () async {},
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
                    kwidth100,
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
