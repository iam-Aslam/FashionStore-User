import 'package:fashionstore/core/constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'category_button_widget.dart';
import 'exclusive_widget.dart';
import 'header_widget.dart';
import 'search_widget.dart';

//home widget
class WidgetHome extends StatelessWidget {
  const WidgetHome({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: Padding(
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
          const ExclusiveProductWidget(),
          khieght20,
          sideHeading(text: 'Categories'),
          khieght10,
          const Row(
            children: [
              CategoryButton(name: 'Dresses', active: true),
              CategoryButton(name: 'Jackets', active: false),
              CategoryButton(name: 'Jeans', active: false),
              CategoryButton(name: 'Shoese', active: false),
            ],
          ),
          sideHeading(text: 'Top Dresses'),
          khieght10,
          Expanded(
            child: GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 10,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 4.0,
                  mainAxisSpacing: 4.0),
              itemBuilder: (context, index) {
                return Container(
                  color: Colors.yellow,
                );
              },
            ),
          )
        ],
      ),
    )));
  }

  Text sideHeading({required String text}) {
    return Text(
      text,
      style: GoogleFonts.roboto(
        textStyle: const TextStyle(
            letterSpacing: .5,
            fontSize: 20,
            color: Colors.black,
            fontWeight: FontWeight.w900),
      ),
    );
  }
}
