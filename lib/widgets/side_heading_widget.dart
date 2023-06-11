import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: must_be_immutable
class SideHeading extends StatelessWidget {
  String text;
  SideHeading({
    Key? key,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.roboto(
        textStyle: const TextStyle(
            letterSpacing: .5,
            fontSize: 20,
            color: Colors.black,
            fontWeight: FontWeight.w900),
      ),
    );
  }
}
