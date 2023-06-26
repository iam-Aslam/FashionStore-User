import 'package:fashionstore/presentations/detail/detail_product_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';

import '../../../core/constants.dart';

class ExclusiveProductWidget extends StatelessWidget {
  final String id;
  final String name;
  final String subname;
  final int rate;
  final List<dynamic> image;
  final String description;
  const ExclusiveProductWidget({
    Key? key,
    required this.id,
    required this.name,
    required this.subname,
    required this.rate,
    required this.image,
    required this.description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            PageTransition(
                type: PageTransitionType.bottomToTop,
                child: ProductDetailScreen(
                  id: id,
                  name: name,
                  subname: subname,
                  rate: rate,
                  image: image,
                  description: description,
                )));
      },
      child: Material(
        elevation: 5,
        borderRadius: const BorderRadius.all(Radius.circular(20)),
        child: Container(
          height: 100,
          width: 360,
          decoration: BoxDecoration(
            border: Border.all(width: 0.8, color: Colors.grey),
            borderRadius: const BorderRadius.all(Radius.circular(20)),
          ),
          child: Row(
            children: [
              kwidth10,
              Container(
                width: 90,
                height: 70,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                      image: NetworkImage(image[0]),
                      fit: BoxFit.cover,
                    )),
              ),
              kwidth10,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  khieght20,
                  Text(
                    name,
                    style: GoogleFonts.roboto(
                      textStyle: const TextStyle(
                          letterSpacing: .5,
                          fontSize: 15,
                          color: Colors.black,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                  khieght5,
                  SizedBox(
                    width: 150,
                    child: Text(
                      subname,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.roboto(
                        textStyle: const TextStyle(
                            letterSpacing: .5,
                            fontSize: 12,
                            color: Colors.black54,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                  ),
                  khieght5,
                  Text(
                    "₹ $rate.00",
                    style: GoogleFonts.roboto(
                      textStyle: const TextStyle(
                          letterSpacing: .5,
                          fontSize: 15,
                          color: Colors.black,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                ],
              ),
              const Spacer(),
              Container(
                width: 90,
                height: 70,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: const DecorationImage(
                      image: AssetImage('assets/images/offer.png'),
                      fit: BoxFit.cover,
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
