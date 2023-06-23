import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PriceTextWidget extends StatelessWidget {
  const PriceTextWidget({
    Key? key,
    required this.text,
    this.size = 18,
  }) : super(key: key);
  final String text;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Text(text,
        style: GoogleFonts.nunito(
          textStyle: TextStyle(
            fontSize: size,
            fontWeight: FontWeight.w700,
          ),
        ));
  }
}
