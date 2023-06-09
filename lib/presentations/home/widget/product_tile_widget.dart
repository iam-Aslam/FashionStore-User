// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:fashionstore/core/constants.dart';
import 'package:fashionstore/presentations/detail/detail_product_screen.dart';

class ProductTile extends StatelessWidget {
  // final int index;
  final String id;
  final String name;
  final String subname;
  final int rate;
  final List<dynamic> image;
  final String description;

  const ProductTile({
    Key? key,
    //required this.index,
    required this.id,
    required this.name,
    required this.subname,
    required this.rate,
    required this.image,
    required this.description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // log('Hello I a product ${index.toString} tile on tap...');
        Navigator.push(context, MaterialPageRoute(
          builder: (context) {
            return ProductDetailScreen(
              id: id,
              name: name,
              subname: subname,
              rate: rate,
              image: image,
              description: description,
            );
          },
        ));
      },
      child: Column(
        children: [
          Container(
            width: 180,
            height: 180,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                image: DecorationImage(
                  image: NetworkImage(image[0]),
                  fit: BoxFit.cover,
                )),
            child: Stack(
              children: [
                Positioned(
                    left: 125,
                    top: 0,
                    child: IconButton(
                      icon: const Icon(
                        CupertinoIcons.heart_circle,
                        color: Colors.white,
                        size: 24,
                      ),
                      onPressed: () {},
                    ))
              ],
            ),
          ),
          khieght10,
          Text(
            name,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            style: GoogleFonts.roboto(
              textStyle: const TextStyle(
                  letterSpacing: .5,
                  fontSize: 15,
                  color: Colors.black,
                  fontWeight: FontWeight.w900),
            ),
          ),
          khieght5,
          Text(
            subname,
            style: GoogleFonts.roboto(
              textStyle: const TextStyle(
                  letterSpacing: .5,
                  fontSize: 12,
                  color: Colors.black54,
                  fontWeight: FontWeight.w700),
            ),
          ),
          khieght5,
          Text(
            "₹$rate.00",
            style: GoogleFonts.roboto(
              textStyle: const TextStyle(
                  letterSpacing: .5,
                  fontSize: 15,
                  color: Colors.black,
                  fontWeight: FontWeight.w900),
            ),
          ),
        ],
      ),
    );
  }
}
