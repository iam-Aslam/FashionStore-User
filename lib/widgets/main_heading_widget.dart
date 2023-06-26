import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MainHeading extends StatelessWidget {
  const MainHeading({
    Key? key,
    required this.text,
  }) : super(key: key);
  final String text;
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
