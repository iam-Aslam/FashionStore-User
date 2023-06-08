import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fashionstore/core/constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'category_button_widget.dart';
import 'product_tile_widget.dart';
import 'exclusive_widget.dart';
import 'header_widget.dart';
import 'search_widget.dart';

//home widget
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
      padding: const EdgeInsets.only(left: 15, right: 15, top: 20),
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
            SearchWidget(),
            khieght30,
            const ExclusiveProductWidget(),
            khieght20,
            sideHeading(text: 'Categories'),
            khieght10,
            const Row(
              children: [
                CategoryButton(name: 'Men', active: true),
                CategoryButton(name: 'Women', active: false),
                CategoryButton(name: 'Boys', active: false),
                CategoryButton(name: 'Girls', active: false),
              ],
            ),
            Row(
              children: [
                sideHeading(text: 'Top Dresses'),
                const Spacer(),
                TextButton(onPressed: () {}, child: const Text('View All'))
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
                        //index: index,
                      );
                    },
                  );
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  return const CircularProgressIndicator();
                }
              },
            )
          ],
        ),
      ),
    )));
  }

  Text sideHeading({required String text}) {
    return Text(
      text,
      style: GoogleFonts.roboto(
        textStyle: const TextStyle(
            letterSpacing: .5,
            fontSize: 20,
            color: Colors.black,
            fontWeight: FontWeight.w900),
      ),
    );
  }
}
