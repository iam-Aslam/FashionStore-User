import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fashionstore/core/constants.dart';
import 'package:fashionstore/presentations/home/widget/shimmer_widget.dart';
import 'package:fashionstore/presentations/home/widget/product_tile_widget.dart';
import 'package:flutter/material.dart';
import 'widgets/custom_search_widget.dart';

List<dynamic> availableProducts = [];
List<dynamic> filteredProducts = [];

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    /*24 is for notification bar on Android*/
    final double itemHeight = (size.height - kToolbarHeight - 24) / 2.5;
    final double itemWidth = size.width / 2;
    return SafeArea(
        child: Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 8.0, left: 12, right: 12),
        child: Column(
          children: [
            khieght10,
            CustomSearchWidget(
              onChanged: filterUsers,
            ),
            khieght10,
            Expanded(
              child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('products')
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return const CircularProgressIndicator();
                  } else if (snapshot.hasData) {
                    log('Data Received');
                    availableProducts = snapshot.data!.docs;
                    return GridView.builder(
                      shrinkWrap: true,
                      itemCount: filteredProducts.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: (itemWidth / itemHeight),
                          crossAxisSpacing: 16.0,
                          mainAxisSpacing: 16.0),
                      itemBuilder: (context, index) {
                        final DocumentSnapshot productSnap =
                            filteredProducts[index];
                        return ProductTile(
                          id: productSnap['id'],
                          name: productSnap['name'],
                          subname: productSnap['subname'],
                          rate: productSnap['price'],
                          image: productSnap['image'],
                          description: productSnap['description'],
                        );
                      },
                    );
                  } else if (snapshot.connectionState ==
                      ConnectionState.waiting) {
                    return const HomeProductShimmerEffect();
                  }
                  return const HomeProductShimmerEffect();
                },
              ),
            )
          ],
        ),
      ),
    ));
  }

  void filterUsers(String query) {
    setState(() {
      filteredProducts = availableProducts.where((doc) {
        String name = doc.data()['name'].toLowerCase();
        String searchLower = query.toLowerCase();
        return name.contains(searchLower);
      }).toList();
    });
  }
}
