import 'dart:developer';

import 'package:fashionstore/core/constants.dart';
import 'package:fashionstore/model/functions.dart';
import 'package:fashionstore/widgets/appbar.dart';
import 'package:fashionstore/widgets/main_heading_widget.dart';
import 'package:flutter/material.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var address = getAddressDocument();
    log(address.toString());
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.only(left: 12.0, right: 10, top: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Appbar(
                goBack: true,
              ),
              khieght10,
              MainHeading(
                text: 'Delivery Address',
              ),
              khieght10,
              Center(
                child: IntrinsicHeight(
                  child: Container(
                    width: size.width * 0.9,
                    decoration: const BoxDecoration(
                      // color: Colors.amber,
                      border: Border(
                        top: BorderSide(
                          width: 1,
                          color: Colors.black,
                        ),
                        bottom: BorderSide(color: Colors.black, width: 1),
                        right: BorderSide(
                          width: 1,
                          color: Colors.black,
                        ),
                        left: BorderSide(color: Colors.black, width: 1), // Ad
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Address",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          const Text(
                            "prakfalf",
                            style: TextStyle(
                              fontSize: 15,
                            ),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          const Text(
                            "state",
                            style: TextStyle(
                              fontSize: 15,
                            ),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          const Text(
                            //"${addressList[selectedAddressIndex]['city']} - ${addressList[selectedAddressIndex]['pin code']}",
                            'address',
                            style: TextStyle(
                              fontSize: 15,
                            ),
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              InkWell(
                                onTap: () {
                                  //changeAddressPopUp(size);
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.grey,
                                      width: 1.0,
                                    ),
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  child: const Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Center(
                                      child: Text(
                                        'Change',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              )
              // : Center(
              //     child: GestureDetector(
              //       onTap: () {
              //         Navigator.push(
              //             context,
              //             MaterialPageRoute(
              //               builder: (context) => AddNewAddresScreen(
              //                 fromCheckOut: true,
              //               ),
              //             ));
              //       },
              //       child: Container(
              //         width: size.width * 0.9,
              //         height: size.height * 0.1,
              //         decoration: const BoxDecoration(
              //           // color: Colors.amber,
              //           border: Border(
              //             top: BorderSide(
              //               width: 1,
              //               color: kBlackColor,
              //             ),
              //             bottom:
              //                 BorderSide(color: kBlackColor, width: 1),
              //             right: BorderSide(
              //               width: 1,
              //               color: kBlackColor,
              //             ),
              //             left: BorderSide(
              //                 color: kBlackColor, width: 1), // Ad
              //           ),
              //         ),
              //         child: const Center(
              //             child: Text(
              //           "Add New Address",
              //           style: TextStyle(
              //             fontSize: 18,
              //           ),
              //         )),
              //       ),
              //     ),
              //   ),
            ],
          ),
        ),
      ),
    );
  }
}
