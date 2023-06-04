import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CategoryButton extends StatelessWidget {
  final String name;
  final bool active;
  const CategoryButton({
    required this.name,
    required this.active,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 3),
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5.0),
            shape: RoundedRectangleBorder(
                side: const BorderSide(color: Colors.black38),
                borderRadius: BorderRadius.circular(30.0)),
            backgroundColor: active == true ? Colors.black : Colors.white,
            foregroundColor: Colors.white,
          ),
          onPressed: () {},
          child: Text(
            name,
            style: GoogleFonts.roboto(
              textStyle: TextStyle(
                letterSpacing: .5,
                fontSize: 12,
                color: active == true ? Colors.white : Colors.black,
              ),
            ),
          )),
    );
  }
}
