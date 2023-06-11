import 'package:fashionstore/presentations/detail/widgets/quantity_widget.dart';
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
String? _selectedLanguage;
String? _selectedColor;

final List<String> _languages = ['S', 'M', 'L', 'XL', 'XXL'];
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
                      const QuantityCartWidget(),
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
                                children: _languages
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
                                          selected:
                                              _selectedLanguage == language,
                                          onSelected: (selected) {
                                            if (selected) {
                                              _selectLanguage(language);
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
                                  .map((color) => Container(
                                        decoration: BoxDecoration(
                                          // color: Colors.white,
                                          border: Border.all(
                                            color: _selectedLanguage == color
                                                ? Colors.black
                                                : Colors.transparent,
                                            width: _selectedLanguage == color
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
                                          shape: const CircleBorder(
                                            side: BorderSide(
                                                width: 0.75,
                                                color: Colors.grey,
                                                style: BorderStyle.solid),
                                          ),
                                          selected: _selectedColor == color,
                                          onSelected: (value) {
                                            setState(() {
                                              _selectedColor = color;
                                            });
                                          },
                                        ),
                                      ))
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
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Total Price',
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
                      kwidth60,
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(
                                horizontal: width / 8, vertical: 12.0),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.0)),
                            backgroundColor: Colors.black,
                            foregroundColor: Colors.white,
                          ),
                          onPressed: () {},
                          child: Row(
                            children: [
                              const Icon(CupertinoIcons.bag),
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
    )));
  }

  // ignore: unused_element
  void _selectColor(String color) {
    setState(() {
      _selectedColor = color;
    });
  }

  void _selectLanguage(String language) {
    setState(() {
      _selectedLanguage = language;
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
