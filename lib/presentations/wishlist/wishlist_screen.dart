import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fashionstore/core/constants.dart';
import 'package:fashionstore/presentations/home/widget/shimmer_widget.dart';
import 'package:fashionstore/widgets/appbar.dart';
import 'package:fashionstore/widgets/main_heading_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'widgets/wishlist_widget.dart';

class ScreenWishlist extends StatelessWidget {
  const ScreenWishlist({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String email = FirebaseAuth.instance.currentUser!.email!;
    var size = MediaQuery.of(context).size;
    var height = size.height;
    return SafeArea(
        child: Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 12.0, right: 10, top: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Appbar(goBack: false),
            khieght10,
            const MainHeading(
              text: 'Wishlist',
            ),
            khieght10,
            SizedBox(
              height: height / 1.38,
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('wishlist')
                    .where('email', isEqualTo: email)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final List<DocumentSnapshot> documents =
                        snapshot.data!.docs;
                    return documents.isNotEmpty
                        ? ListView.separated(
                            shrinkWrap: true,
                            separatorBuilder: (context, index) => khieght20,
                            itemCount: documents.length,
                            itemBuilder: (context, index) {
                              return WishlistProductWidget(
                                id: documents[index].get('id'),
                                productId: documents[index].get('productid'),
                              );
                            },
                          )
                        : const Padding(
                            padding: EdgeInsets.symmetric(vertical: 250.0),
                            child: Center(
                              child: Text('Wishlist is Empty'),
                            ),
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
          ],
        ),
      ),
    ));
  }
}
