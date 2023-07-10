import 'dart:developer';
import 'package:fashionstore/model/functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import '../../core/constants.dart';
import '../../model/cart_model.dart';
import '../checkout/checkout.dart';
import 'widgets/image_widget.dart';

class ProductDetailScreen extends StatefulWidget {
  const ProductDetailScreen({
    Key? key,
    required this.id,
    required this.name,
    required this.subname,
    required this.rate,
    required this.image,
    required this.description,
  }) : super(key: key);
  final String id;
  final String name;
  final String subname;
  final int rate;
  final List<dynamic> image;
  final String description;

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

int value = 0;
String? _selectedsize;
String? _selectedColor;
final String currentUser = FirebaseAuth.instance.currentUser!.email!;
final List<String> _sizes = ['S', 'M', 'L', 'XL', 'XXL'];
final List<String> _colours = ['1', '2', '3', '4'];
Color getColor(String color) {
  switch (color) {
    case '1':
      return Colors.white;
    case '2':
      return Colors.black;
    case '3':
      return Colors.green;
    case '4':
      return Colors.orange;
    default:
      return Colors.grey;
  }
}

String getColorName(String color) {
  switch (color) {
    case '1':
      return 'White';
    case '2':
      return 'Black';
    case '3':
      return 'Green';
    case '4':
      return 'Orange';
    default:
      return 'Black';
  }
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  bool isAddedToWishlist = false;
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
    var size = MediaQuery.of(context).size;
    var height = size.height;
    var width = size.width;
    return SafeArea(
        child: Scaffold(
            body: SingleChildScrollView(
      child: Column(
        children: [
          DetailImageWidget(
            widget: widget,
            id: widget.id,
            isAddedToWishlist: isAddedToWishlist,
          ),
          Material(
            elevation: 50,
            child: Container(
              height: height / 2.26,
              width: width / 1,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(40),
                    topLeft: Radius.circular(40)),
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 20.0, top: 20, right: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.name,
                              style: GoogleFonts.roboto(
                                textStyle: const TextStyle(
                                    letterSpacing: .5,
                                    fontSize: 20,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w700),
                              ),
                            ),
                            khieght10,
                            Text(
                              widget.subname,
                              style: GoogleFonts.roboto(
                                textStyle: const TextStyle(
                                  letterSpacing: .5,
                                  fontSize: 15,
                                  color: Colors.black54,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const Spacer(),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Price',
                              style: GoogleFonts.roboto(
                                textStyle: const TextStyle(
                                    letterSpacing: .5,
                                    fontSize: 10,
                                    color: Colors.grey,
                                    fontWeight: FontWeight.w700),
                              ),
                            ),
                            SizedBox(
                              width: 72,
                              child: Text(
                                '₹${widget.rate.toString()}.00',
                                overflow: TextOverflow.ellipsis,
                                style: GoogleFonts.roboto(
                                  textStyle: const TextStyle(
                                      letterSpacing: .5,
                                      fontSize: 15,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w900),
                                ),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                    khieght20,
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Size',
                              style: GoogleFonts.roboto(
                                textStyle: const TextStyle(
                                    letterSpacing: .5,
                                    fontSize: 18,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w700),
                              ),
                            ),
                            khieght5,
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Wrap(
                                  spacing: 3.0,
                                  children: _sizes
                                      .map((language) => ChoiceChip(
                                            label: Text(
                                              language,
                                              style: const TextStyle(
                                                  fontSize: 15,
                                                  color: Colors.grey),
                                            ),
                                            backgroundColor: Colors.white,
                                            disabledColor: Colors.white,
                                            selectedColor: Colors.black,
                                            shape: const CircleBorder(
                                              side: BorderSide(
                                                  width: 1,
                                                  color: Colors.grey,
                                                  style: BorderStyle.solid),
                                            ),
                                            selected: _selectedsize == language,
                                            onSelected: (selected) {
                                              if (selected) {
                                                _selectSize(language);
                                              }
                                            },
                                          ))
                                      .toList(),
                                ),
                              ],
                            ),
                            khieght10,
                            Text(
                              'Description',
                              style: GoogleFonts.roboto(
                                textStyle: const TextStyle(
                                    letterSpacing: .5,
                                    fontSize: 18,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w700),
                              ),
                            ),
                            khieght10,
                            SizedBox(
                                width: 280,
                                child: Text(
                                  widget.description,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 3,
                                  style: GoogleFonts.roboto(
                                    textStyle: const TextStyle(
                                      letterSpacing: .5,
                                      fontSize: 15,
                                      color: Colors.black54,
                                    ),
                                  ),
                                )),
                          ],
                        ),
                        const Spacer(),
                        Card(
                          elevation: 4,
                          shadowColor: Colors.black,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          color: Colors.grey,
                          child: Column(
                            children: [
                              Wrap(
                                spacing: -12,
                                direction: Axis.vertical,
                                children: _colours
                                    .map(
                                      (color) => Container(
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            color: _selectedsize == color
                                                ? Colors.black
                                                : Colors.transparent,
                                            width: _selectedsize == color
                                                ? 2.0
                                                : 0.0,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                        child: ChoiceChip(
                                          label: Text(
                                            color,
                                            style: const TextStyle(
                                                fontSize: 10,
                                                color: Colors.grey),
                                          ),
                                          backgroundColor: getColor(color),
                                          disabledColor: Colors.yellow,
                                          selectedColor: getColor(color),
                                          shape: CircleBorder(
                                            side: BorderSide(
                                                width: 2,
                                                color: _selectedColor == color
                                                    ? Colors.black
                                                    : Colors.grey,
                                                style: BorderStyle.solid),
                                          ),
                                          selected: _selectedColor == color,
                                          onSelected: (selected) {
                                            if (selected) {
                                              _selectColor(color);
                                            }
                                          },
                                        ),
                                      ),
                                    )
                                    .toList(),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    khieght30,
                    Row(
                      children: [
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.symmetric(
                                  horizontal: width / 12, vertical: 12.0),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0)),
                              backgroundColor: Colors.black,
                              foregroundColor: Colors.white,
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                PageTransition(
                                  type: PageTransitionType.bottomToTop,
                                  child: CheckoutScreen(
                                    totalPrice: (widget.rate).toString(),
                                    totalCount: 1.toString(),
                                  ),
                                ),
                              );
                            },
                            child: Row(
                              children: [
                                const Icon(CupertinoIcons.bag),
                                kwidth10,
                                Text(
                                  'Buy Now',
                                  style: GoogleFonts.poppins(
                                    textStyle: const TextStyle(
                                      letterSpacing: .5,
                                      fontSize: 14,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                              ],
                            )),
                        const Spacer(),
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.symmetric(
                                  horizontal: width / 16, vertical: 12.0),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0)),
                              backgroundColor: Colors.black,
                              foregroundColor: Colors.white,
                            ),
                            onPressed: () {
                              addToCart(
                                  Cart(
                                    productId: widget.id,
                                    price: widget.rate,
                                    totalPrice: widget.rate,
                                    quantity: 1,
                                    email: currentUser,
                                    size: _selectedsize,
                                    color:
                                        getColorName(_selectedColor.toString()),
                                  ),
                                  context);
                            },
                            child: Row(
                              children: [
                                const Icon(CupertinoIcons.cart),
                                kwidth10,
                                Text(
                                  'Add to cart',
                                  style: GoogleFonts.poppins(
                                    textStyle: const TextStyle(
                                      letterSpacing: .5,
                                      fontSize: 14,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                              ],
                            )),
                      ],
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    )));
  }

  void _selectColor(String color) {
    setState(() {
      _selectedColor = color;
    });
  }

  void _selectSize(String size) {
    setState(() {
      _selectedsize = size;
      log(_selectedsize.toString());
    });
  }

  Widget customRadioButton(String text, int index) {
    return Builder(
      builder: (context) {
        return OutlinedButton(
          onPressed: () {
            setState(() {
              value = index;
            });
          },
          style: OutlinedButton.styleFrom(
            shape: const CircleBorder(
              side: BorderSide.none,
            ),
            side: BorderSide(
              color: (value == index) ? Colors.black : Colors.black87,
            ),
            backgroundColor: (value == index) ? Colors.black : Colors.white,
          ),
          child: Text(
            text,
            style: TextStyle(
              color: (value == index) ? Colors.white : Colors.black87,
            ),
          ),
        );
      },
    );
  }
}
