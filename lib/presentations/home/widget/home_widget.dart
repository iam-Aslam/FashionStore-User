import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fashionstore/model/offer_functions.dart';
import 'package:fashionstore/presentations/products/all_products.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fashionstore/core/constants.dart';
import 'package:fashionstore/presentations/Categories/Boys/category_boys.dart';
import 'package:fashionstore/presentations/Categories/Girls/category_women.dart';
import 'package:fashionstore/presentations/Categories/Men/category_men.dart';
import 'package:fashionstore/presentations/Categories/Women/category_women.dart';
import 'package:page_transition/page_transition.dart';
import '../../../widgets/side_heading_widget.dart';
import 'shimmer_widget.dart';
import 'category_button_widget.dart';
import 'exclusive_widget.dart';
import 'header_widget.dart';
import 'product_tile_widget.dart';
import 'search_widget.dart';

class WidgetHome extends StatelessWidget {
  WidgetHome({super.key});

  final Stream<QuerySnapshot> _productsStream =
      FirebaseFirestore.instance.collection('products').snapshots();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    /*24 is for notification bar on Android*/
    final double itemHeight = (size.height - kToolbarHeight - 24) / 2.5;
    final double itemWidth = size.width / 2;
    return SafeArea(
        child: Scaffold(
            body: Padding(
      padding: const EdgeInsets.only(left: 15, right: 15, top: 10),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const HeadWidget(),
            khieght20,
            Text(
              'Welcome,',
              style: GoogleFonts.prompt(
                textStyle: const TextStyle(
                    letterSpacing: .5,
                    fontSize: 30,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Text(
              'Our Fashion Store',
              style: GoogleFonts.prompt(
                textStyle: const TextStyle(
                    letterSpacing: .5,
                    fontSize: 25,
                    color: Colors.black54,
                    fontWeight: FontWeight.w600),
              ),
            ),
            khieght20,
            const SearchWidget(),
            khieght10,
            StreamBuilder(
              stream: getOfferProducts(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final data = snapshot.data;
                  return Container(
                    color: Colors.white,
                    height: 100,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4.0),
                      child: CarouselSlider(
                        options: CarouselOptions(
                          height: 100,
                          enableInfiniteScroll: true,
                          scrollDirection: Axis.horizontal,
                          autoPlay: true,
                          autoPlayCurve: Curves.fastOutSlowIn,
                          autoPlayAnimationDuration:
                              const Duration(milliseconds: 800),
                          viewportFraction: 0.95,
                          enlargeCenterPage: true,
                        ),
                        items: List.generate(data.length, (index) {
                          return Builder(
                            builder: (BuildContext context) {
                              return ExclusiveProductWidget(
                                id: data[index].get('id'),
                                name: data[index].get('name'),
                                subname: data[index].get('subname'),
                                rate: data[index].get('price'),
                                image: data[index].get('image'),
                                description: data[index].get('description'),
                              );
                            },
                          );
                        }),
                      ),
                    ),
                  );
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else if (snapshot.connectionState ==
                    ConnectionState.waiting) {
                  return const HomeProductShimmerEffect();
                } else {
                  return const HomeProductShimmerEffect();
                }
              },
            ),
            khieght20,
            const SideHeading(text: 'Categories'),
            khieght10,
            Row(
              children: [
                CategoryButton(
                  name: 'Men',
                  active: true,
                  onTap: () {
                    Navigator.push(
                        context,
                        PageTransition(
                            type: PageTransitionType.rightToLeft,
                            child: const CategoryMen()));
                  },
                ),
                CategoryButton(
                  name: 'Women',
                  active: true,
                  onTap: () {
                    Navigator.push(
                        context,
                        PageTransition(
                            type: PageTransitionType.rightToLeft,
                            child: const CategoryWomen()));
                  },
                ),
                CategoryButton(
                  name: 'Boys',
                  active: true,
                  onTap: () {
                    Navigator.push(
                        context,
                        PageTransition(
                            type: PageTransitionType.rightToLeft,
                            child: const CategoryBoys()));
                  },
                ),
                CategoryButton(
                  name: 'Girls',
                  active: true,
                  onTap: () {
                    Navigator.push(
                        context,
                        PageTransition(
                            type: PageTransitionType.rightToLeft,
                            child: const CategorGirls()));
                  },
                ),
              ],
            ),
            Row(
              children: [
                SideHeading(text: 'Top Dresses'),
                const Spacer(),
                TextButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) {
                          return const AllProducts();
                        },
                      ));
                    },
                    child: const Text('View All'))
              ],
            ),
            khieght5,
            StreamBuilder<QuerySnapshot>(
              stream: _productsStream,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final List<DocumentSnapshot> documents = snapshot.data!.docs;

                  return GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: documents.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: (itemWidth / itemHeight),
                        crossAxisSpacing: 16.0,
                        mainAxisSpacing: 16.0),
                    itemBuilder: (context, index) {
                      return ProductTile(
                        name: documents[index].get('name'),
                        subname: documents[index].get('subname'),
                        rate: documents[index].get('price'),
                        image: documents[index].get('image'),
                        id: documents[index].get('id'),
                        description: documents[index].get('description'),

                        //index: index,
                      );
                    },
                  );
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else if (snapshot.connectionState ==
                    ConnectionState.waiting) {
                  return const HomeProductShimmerEffect();
                } else {
                  return const HomeProductShimmerEffect();
                }
              },
            )
          ],
        ),
      ),
    )));
  }
}
