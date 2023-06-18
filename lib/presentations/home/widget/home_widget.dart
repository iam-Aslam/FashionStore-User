import 'package:cloud_firestore/cloud_firestore.dart';
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
import 'Shimmer_widget.dart';
import 'category_button_widget.dart';
import 'exclusive_widget.dart';
import 'header_widget.dart';
import 'product_tile_widget.dart';
import 'search_widget.dart';

//home widget
class WidgetHome extends StatefulWidget {
  const WidgetHome({super.key});

  @override
  State<WidgetHome> createState() => _WidgetHomeState();
}

class _WidgetHomeState extends State<WidgetHome> {
  //ScrollController scrollController = ScrollController();
  final Stream<QuerySnapshot> _productsStream =
      FirebaseFirestore.instance.collection('products').snapshots();
  // @override
  // void initState() {
  //   super.initState();
  //   WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
  //     double minScrollExtent1 = scrollController.position.minScrollExtent;
  //     double maxScrollExtent1 = scrollController.position.maxScrollExtent;
  //     animateToMaxMin(maxScrollExtent1, minScrollExtent1, maxScrollExtent1, 25,
  //         scrollController);
  //   });
  // }

  // animateToMaxMin(double max, double min, double direction, int seconds,
  //     ScrollController scrollController) {
  //   scrollController
  //       .animateTo(direction,
  //           duration: Duration(seconds: seconds), curve: Curves.linear)
  //       .then((value) {
  //     direction = direction == max ? min : max;
  //     animateToMaxMin(max, min, direction, seconds, scrollController);
  //   });
  // }

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
            khieght30,
            const ExclusiveProductWidget(),
            khieght20,
            SideHeading(text: 'Categories'),
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
