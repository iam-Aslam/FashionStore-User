// ignore_for_file: must_be_immutable

import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../Search/search_screen.dart';

class SearchWidget extends StatelessWidget {
  const SearchWidget({
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
      onTap: () {
        log('Search Field');
        Navigator.push(context, MaterialPageRoute(
          builder: (context) {
            return const SearchScreen();
          },
        ));
      },
    );
  }
}
