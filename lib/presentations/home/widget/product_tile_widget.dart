import 'package:fashionstore/model/functions.dart';
import 'package:fashionstore/model/wishlist_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fashionstore/core/constants.dart';
import 'package:fashionstore/presentations/detail/detail_product_screen.dart';
import 'package:page_transition/page_transition.dart';

class ProductTile extends StatefulWidget {
  final String id;
  final String name;
  final String subname;
  final int rate;
  final List<dynamic> image;
  final String description;

  const ProductTile({
    Key? key,
    required this.id,
    required this.name,
    required this.subname,
    required this.rate,
    required this.image,
    required this.description,
  }) : super(key: key);

  @override
  State<ProductTile> createState() => _ProductTileState();
}

class _ProductTileState extends State<ProductTile> {
  bool isAddedToWishlist = false;
//checking funciton
  Future<void> checkIfProductInWishlist() async {
    String email = FirebaseAuth.instance.currentUser!.email!;
    bool exists = await checkIfProductExistsInWishlist(email, widget.id);
    setState(() {
      isAddedToWishlist = exists;
    });
  }

  @override
  void initState() {
    super.initState();
    checkIfProductInWishlist();
  }

  @override
  Widget build(BuildContext context) {
    String email = FirebaseAuth.instance.currentUser!.email!;
    // Future<bool> documentExists = checkIfDocumentExists(id);
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            PageTransition(
                type: PageTransitionType.bottomToTop,
                child: ProductDetailScreen(
                  id: widget.id,
                  name: widget.name,
                  subname: widget.subname,
                  rate: widget.rate,
                  image: widget.image,
                  description: widget.description,
                )));
      },
      child: Column(
        children: [
          Container(
            width: 180,
            height: 180,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                image: DecorationImage(
                  image: NetworkImage(widget.image[0]),
                  fit: BoxFit.cover,
                )),
            child: Stack(
              children: [
                Positioned(
                    left: 127,
                    top: -4,
                    child: IconButton(
                      icon: Icon(
                        isAddedToWishlist
                            ? CupertinoIcons.suit_heart_fill
                            : CupertinoIcons.heart,
                        color: Colors.black,
                        size: 24,
                      ),
                      onPressed: () async {
                        Wishlist wishlist = Wishlist(
                          email: email,
                          productId: widget.id,
                        );
                        if (isAddedToWishlist) {
                          removeWishlist(wishlist, context);
                        } else {
                          addWishlist(wishlist, context);
                        }
                        setState(() {
                          isAddedToWishlist = !isAddedToWishlist;
                        });
                      },
                    ))
              ],
            ),
          ),
          khieght10,
          Text(
            widget.name,
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
            widget.subname,
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
            "₹${widget.rate}.00",
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
