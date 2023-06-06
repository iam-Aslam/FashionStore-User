// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: must_be_immutable

import 'dart:developer';

import 'package:fashionstore/presentations/detail/detail_product_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:fashionstore/core/constants.dart';

class ProductTile extends StatelessWidget {
  final int index;
  const ProductTile({
    Key? key,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        log('Hello I a product ${index.toString} tile on tap...');
        Navigator.push(context, MaterialPageRoute(
          builder: (context) {
            return const ProductDetailScreen();
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
                image: const DecorationImage(
                  image: AssetImage('assets/images/nike.jpeg'),
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
            'Roller Rabbit',
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
            'Vado Odello Dress',
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
            "₹198.00",
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
