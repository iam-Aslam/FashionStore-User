import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/constants.dart';

class OnboardContent extends StatelessWidget {
  const OnboardContent({
    Key? key,
    required this.image,
    required this.title1,
    required this.title2,
    required this.description1,
    required this.description2,
  }) : super(key: key);
  final String image, title1, title2, description1, description2;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var height = size.height;
    var width = size.width;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: width / 1,
          height: height / 1.9,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              image: DecorationImage(
                image: AssetImage(image),
                fit: BoxFit.fill,
              )),
        ),
        khieght40,
        Text(
          title1,
          style: const TextStyle(fontSize: 30, fontWeight: FontWeight.w900),
        ),
        khieght10,
        Text(
          title2,
          style: const TextStyle(fontSize: 30, fontWeight: FontWeight.w900),
        ),
        khieght20,
        Text(
          description1,
          style: GoogleFonts.poppins(
            textStyle: const TextStyle(
              letterSpacing: .5,
              fontSize: 14,
              color: Colors.black54,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Text(
          description2,
          style: GoogleFonts.poppins(
            textStyle: const TextStyle(
              letterSpacing: .5,
              fontSize: 14,
              color: Colors.black54,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        khieght30,
      ],
    );
  }
}
