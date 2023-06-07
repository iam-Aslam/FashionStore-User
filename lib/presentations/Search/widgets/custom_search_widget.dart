import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomSearchWidget extends StatelessWidget {
  const CustomSearchWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CupertinoSearchTextField(
      borderRadius: BorderRadius.circular(30),
      backgroundColor: Colors.grey.withOpacity(0.4),
      prefixIcon: const Icon(
        CupertinoIcons.search,
        color: Colors.grey,
      ),
      suffixIcon: const Icon(
        CupertinoIcons.xmark_circle_fill,
        color: Colors.grey,
      ),
      style: const TextStyle(color: Colors.black),
      onChanged: (value) {
        log('Search Field');
      },
      // onTap: () {
      //   log('Search Field');
      // },
    );
  }
}
