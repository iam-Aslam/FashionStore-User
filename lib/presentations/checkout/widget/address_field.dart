import 'package:fashionstore/core/constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AddressField extends StatelessWidget {
  const AddressField({
    Key? key,
    required this.id,
    required this.value,
  }) : super(key: key);
  final String id;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text("$id :",
            style: GoogleFonts.roboto(
              textStyle:
                  const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            )),
        kwidth10,
        Text(
          value,
          style: const TextStyle(
              fontSize: 15, fontWeight: FontWeight.bold, color: Colors.grey),
        ),
      ],
    );
  }
}
