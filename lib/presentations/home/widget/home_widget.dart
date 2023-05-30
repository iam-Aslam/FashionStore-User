import 'package:fashionstore/core/constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'header_widget.dart';
import 'search_widget.dart';

class WidgetHome extends StatelessWidget {
  const WidgetHome({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: SingleChildScrollView(
                child: Padding(
      padding: const EdgeInsets.only(left: 15, right: 15, top: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const HeadWidget(),
          khieght20,
          Text(
            'Welcome,',
            style: GoogleFonts.prompt(
              textStyle: const TextStyle(
                  letterSpacing: .5,
                  fontSize: 30,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Text(
            'Our Fashion Store',
            style: GoogleFonts.prompt(
              textStyle: const TextStyle(
                  letterSpacing: .5,
                  fontSize: 25,
                  color: Colors.black54,
                  fontWeight: FontWeight.w600),
            ),
          ),
          khieght20,
          const SearchWidget(),
          khieght30,
          Material(
            elevation: 12,
            borderRadius: const BorderRadius.all(Radius.circular(20)),
            child: Container(
              height: 80,
              width: 360,
              decoration: const BoxDecoration(
                //color: Colors.amber,
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
              child: Row(
                children: [
                  kwidth10,
                  Container(
                    width: 70,
                    height: 60,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: const DecorationImage(
                          image: AssetImage('assets/images/splash.jpg'),
                          fit: BoxFit.cover,
                        )),
                  ),
                  kwidth10,
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Axel Arigato'),
                      Text('Clean 90 Triple Sneakers'),
                      Text("₹245.00}"),
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    ))));
  }
}
