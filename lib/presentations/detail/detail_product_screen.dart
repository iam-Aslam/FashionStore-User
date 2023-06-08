// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/constants.dart';

class ProductDetailScreen extends StatefulWidget {
  const ProductDetailScreen({
    Key? key,
    required this.id,
    required this.name,
    required this.subname,
    required this.rate,
    required this.image,
  }) : super(key: key);
  final String id;
  final String name;
  final String subname;
  final int rate;
  final List<dynamic> image;
  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

int value = 0;

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var height = size.height;
    var width = size.width;
    return SafeArea(
        child: Scaffold(
            body: Column(
      children: [
        Container(
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
              Padding(
                padding: const EdgeInsets.only(left: 10.0, top: 10, right: 12),
                child: Row(
                  children: [
                    IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(
                          CupertinoIcons.arrow_left_circle_fill,
                          size: 40,
                        )),
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.only(top: 12.0),
                      child: CircleAvatar(
                        radius: 16,
                        child: IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              CupertinoIcons.bag,
                              size: 20,
                            )),
                      ),
                    )
                  ],
                ),
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.only(bottom: 18.0, right: 18),
                child: Row(
                  children: [
                    const Spacer(),
                    CircleAvatar(
                      radius: 16,
                      child: IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            CupertinoIcons.heart,
                            size: 20,
                          )),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        Material(
          elevation: 50,
          child: Container(
            height: height / 2.26,
            width: width / 1,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(40), topLeft: Radius.circular(40)),
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
                      Container(
                        width: width / 3.75,
                        height: height / 24,
                        decoration: BoxDecoration(
                            color: const Color.fromARGB(108, 181, 12, 12),
                            borderRadius: BorderRadius.circular(15)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            IconButton(
                                onPressed: () {},
                                icon: const Icon(
                                  Icons.minimize_outlined,
                                  size: 15,
                                )),
                            const Text('1'),
                            IconButton(
                                onPressed: () {},
                                icon: const Icon(
                                  Icons.add,
                                  size: 15,
                                ))
                          ],
                        ),
                      )
                    ],
                  ),
                  khieght20,
                  Row(
                    children: [
                      kwidth10,
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
                    ],
                  ),
                  khieght5,
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      customRadioButton('S', 0),
                      customRadioButton('M', 1),
                      customRadioButton('L', 2),
                      customRadioButton('XL', 3),
                      customRadioButton('XXL', 4),
                    ],
                  )
                ],
              ),
            ),
          ),
        )
      ],
    )));
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
