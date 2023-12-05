import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fashionstore/presentations/home/widget/categories.dart';
import 'package:fashionstore/presentations/home/widget/offer_widget.dart';
import 'package:fashionstore/presentations/products/all_products.dart';
import 'package:fashionstore/provider/product_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fashionstore/core/constants.dart';
import 'package:provider/provider.dart';
import '../../../widgets/side_heading_widget.dart';
import 'shimmer_widget.dart';
import 'header_widget.dart';
import 'product_tile_widget.dart';
import 'search_widget.dart';

class WidgetHome extends StatelessWidget {
  WidgetHome({super.key});

  @override
  Widget build(BuildContext context) {
    final productProvider =
        Provider.of<ProductProvider>(context, listen: false);
    var size = MediaQuery.of(context).size;
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
            OfferWidget(),
            khieght20,
            const SideHeading(text: 'Categories'),
            khieght10,
            Categories(),
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
              stream: productProvider.productsStream,
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
                        crossAxisSpacing: 10.0,
                        mainAxisSpacing: 16.0),
                    itemBuilder: (context, index) {
                      return ProductTile(
                        name: documents[index].get('name'),
                        subname: documents[index].get('subname'),
                        rate: documents[index].get('price'),
                        image: documents[index].get('image'),
                        id: documents[index].get('id'),
                        description: documents[index].get('description'),
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
