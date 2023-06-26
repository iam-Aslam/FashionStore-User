import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SideHeading extends StatelessWidget {
  const SideHeading({
    Key? key,
    required this.text,
  }) : super(key: key);
  final String text;

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
