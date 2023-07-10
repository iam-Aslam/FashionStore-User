import 'package:flutter/material.dart';
import '../detail_product_screen.dart';
import 'addwishlist_widget.dart';
import 'appbar.dart';

class DetailImageWidget extends StatelessWidget {
  const DetailImageWidget({
    Key? key,
    required this.isAddedToWishlist,
    required this.id,
    required this.widget,
  }) : super(key: key);
  final bool isAddedToWishlist;
  final String id;

  final ProductDetailScreen widget;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var height = size.height;
    var width = size.width;
    return Container(
      width: width / 1,
      height: height / 1.9,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(0),
          image: DecorationImage(
            image: NetworkImage(widget.image[0]),
            fit: BoxFit.cover,
          )),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 10.0, top: 10, right: 12),
            child: DetailAppbar(),
          ),
          const Spacer(),
          AddWishlistWidget(
            isAddedToWishlist: isAddedToWishlist,
            id: id,
          )
        ],
      ),
    );
  }
}
