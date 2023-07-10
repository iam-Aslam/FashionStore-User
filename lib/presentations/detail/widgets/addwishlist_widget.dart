import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fashionstore/model/functions.dart';
import 'package:fashionstore/model/wishlist_model.dart';

// ignore: must_be_immutable
class AddWishlistWidget extends StatefulWidget {
  bool isAddedToWishlist;
  final String id;
  AddWishlistWidget({
    Key? key,
    required this.isAddedToWishlist,
    required this.id,
  }) : super(key: key);

  @override
  State<AddWishlistWidget> createState() => _AddWishlistWidgetState();
}

class _AddWishlistWidgetState extends State<AddWishlistWidget> {
  @override
  Widget build(BuildContext context) {
    String email = FirebaseAuth.instance.currentUser!.email!;
    return Padding(
      padding: const EdgeInsets.only(bottom: 18.0, right: 18),
      child: Row(
        children: [
          const Spacer(),
          CircleAvatar(
            radius: 16,
            child: IconButton(
                onPressed: () async {
                  Wishlist wishlist = Wishlist(
                    email: email,
                    productId: widget.id,
                  );
                  if (widget.isAddedToWishlist) {
                    removeWishlist(wishlist, context);
                  } else {
                    addWishlist(wishlist, context);
                  }
                  setState(() {
                    widget.isAddedToWishlist = !widget.isAddedToWishlist;
                  });
                },
                icon: Icon(
                  widget.isAddedToWishlist
                      ? CupertinoIcons.suit_heart_fill
                      : CupertinoIcons.heart,
                  size: 20,
                )),
          ),
        ],
      ),
    );
  }
}
