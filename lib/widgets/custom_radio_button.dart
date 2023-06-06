import 'package:flutter/material.dart';

Widget customRadioButton(String text, int index, {int value = 0}) {
  return OutlinedButton(
    onPressed: () {
      // setState(() {
      //   value = index;
      // });
    },
    style: OutlinedButton.styleFrom(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      side: BorderSide(
        color: (value == index) ? Colors.green : Colors.black,
      ),
    ),
    child: Text(
      text,
      style: TextStyle(
        color: (value == index) ? Colors.green : Colors.black,
      ),
    ),
  );
}
