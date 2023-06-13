import 'package:flutter/material.dart';

import '../detail_product_screen.dart';
import 'addwishlist_widget.dart';
import 'appbar.dart';

class DetailImageWidget extends StatelessWidget {
  const DetailImageWidget({
    super.key,
    required this.width,
    required this.height,
    required this.widget,
  });

  final double width;
  final double height;
  final ProductDetailScreen widget;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width / 1,
      height: height / 1.9,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(0),
          image: DecorationImage(
            image: NetworkImage(widget.image[0]),
            fit: BoxFit.cover,
          )),
      child: const Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 10.0, top: 10, right: 12),
            child: DetailAppbar(),
          ),
          Spacer(),
          AddWishlistWidget()
        ],
      ),
    );
  }
}
