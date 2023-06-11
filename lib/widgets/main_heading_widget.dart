import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: must_be_immutable
class MainHeading extends StatelessWidget {
  String text;
  MainHeading({
    Key? key,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0),
      child: Text(
        text,
        style: GoogleFonts.nunito(
          textStyle: const TextStyle(
              letterSpacing: .5,
              fontSize: 26,
              color: Colors.black,
              fontWeight: FontWeight.w700),
        ),
      ),
    );
  }
}
