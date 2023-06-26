import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class EditButton extends StatelessWidget {
  final String name;

  final VoidCallback onTap;
  const EditButton({
    Key? key,
    required this.name,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 3),
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            shape: RoundedRectangleBorder(
                side: const BorderSide(color: Colors.black38),
                borderRadius: BorderRadius.circular(10.0)),
            backgroundColor: Colors.black,
            foregroundColor: Colors.white,
          ),
          onPressed: onTap,
          child: Text(
            name,
            style: GoogleFonts.roboto(
              textStyle: const TextStyle(
                letterSpacing: .5,
                fontSize: 12,
                color: Colors.white,
              ),
            ),
          )),
    );
  }
}
