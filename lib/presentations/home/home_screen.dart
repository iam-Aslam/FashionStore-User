import 'dart:developer';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:fashionstore/presentations/account/account_screen.dart';
import 'package:fashionstore/presentations/cart/cart_screen.dart';
import 'package:fashionstore/presentations/home/widget/home_widget.dart';
import 'package:fashionstore/presentations/wishlist/wishlist_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentselected = 0;
  final pages = [
    WidgetHome(),
    const ScreenCart(),
    const ScreenWishlist(),
    const ScreenAccount(),
  ];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      bottomNavigationBar: Material(
        elevation: 50,
        child: Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(30), topLeft: Radius.circular(30)),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20),
            child: GNav(
                gap: 8,
                backgroundColor: Colors.white,
                color: Colors.white,
                activeColor: Colors.white,
                tabBackgroundColor: Colors.black,
                padding: const EdgeInsets.all(8),
                onTabChange: (index) {
                  setState(() {
                    currentselected = index;
                  });
                },
                tabs: [
                  GButton(
                    icon: CupertinoIcons.house_fill,
                    iconColor: Colors.black,
                    text: 'Home',
                    textStyle: GoogleFonts.inconsolata(
                      textStyle: const TextStyle(
                          letterSpacing: .5, fontSize: 15, color: Colors.white),
                    ),
                  ),
                  GButton(
                    icon: CupertinoIcons.cart_fill,
                    iconColor: Colors.black,
                    text: 'Cart',
                    textStyle: GoogleFonts.inconsolata(
                      textStyle: const TextStyle(
                          letterSpacing: .5, fontSize: 15, color: Colors.white),
                    ),
                  ),
                  GButton(
                    icon: CupertinoIcons.heart_fill,
                    iconColor: Colors.black,
                    text: 'Wishlist',
                    textStyle: GoogleFonts.inconsolata(
                      textStyle: const TextStyle(
                          letterSpacing: .5, fontSize: 15, color: Colors.white),
                    ),
                  ),
                  GButton(
                    icon: CupertinoIcons.person_solid,
                    iconColor: Colors.black,
                    text: 'Account',
                    textStyle: GoogleFonts.inconsolata(
                      textStyle: const TextStyle(
                          letterSpacing: .5, fontSize: 15, color: Colors.white),
                    ),
                  ),
                ]),
          ),
        ),
      ),
      body: pages[currentselected],
    ));
  }
}
