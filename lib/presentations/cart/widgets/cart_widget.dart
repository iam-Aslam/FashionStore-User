import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/constants.dart';

class CartWidget extends StatelessWidget {
  const CartWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Slidable(
      endActionPane: ActionPane(
        motion: const StretchMotion(),
        extentRatio: 0.15,
        children: [
          SlidableAction(
              borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(20),
                  bottomRight: Radius.circular(20)),
              onPressed: (context) {},
              backgroundColor: Colors.black,
              foregroundColor: Colors.white,
              icon: Icons.delete_rounded),
        ],
      ),
      child: Material(
        elevation: 12,
        borderRadius: const BorderRadius.all(Radius.circular(20)),
        child: Container(
          height: 100,
          width: 360,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
          child: Row(
            children: [
              kwidth10,
              Container(
                width: 90,
                height: 80,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: const DecorationImage(
                      image: AssetImage('assets/images/nike.jpg'),
                      fit: BoxFit.cover,
                    )),
              ),
              kwidth10,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  khieght20,
                  Text(
                    'Axel Arigato',
                    style: GoogleFonts.roboto(
                      textStyle: const TextStyle(
                          letterSpacing: .5,
                          fontSize: 15,
                          color: Colors.black,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                  Text(
                    'Clean 90 Triple Sneakers',
                    style: GoogleFonts.roboto(
                      textStyle: const TextStyle(
                          letterSpacing: .5,
                          fontSize: 12,
                          color: Colors.black54,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                  Row(
                    children: [
                      Column(
                        children: [
                          khieght20,
                          Text(
                            "₹245.00",
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
                      kwidth90,
                      Container(
                          height: 30,
                          decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius: BorderRadius.circular(30)),
                          child: SizedBox(
                            width: size.width * 0.2,
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                GestureDetector(
                                  onTap: () async {
                                    log('Reduce count');
                                  },
                                  child: const Icon(
                                    CupertinoIcons.minus,
                                    size: 15,
                                  ),
                                ),
                                const Text(
                                  '1',
                                  style: TextStyle(fontSize: 20),
                                ),
                                GestureDetector(
                                  onTap: () async {
                                    log('Add count');
                                  },
                                  child: const Icon(
                                    CupertinoIcons.add,
                                    size: 15,
                                  ),
                                ),
                              ],
                            ),
                          ))
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
