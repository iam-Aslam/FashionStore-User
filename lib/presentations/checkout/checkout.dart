// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fashionstore/core/strings.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:fashionstore/core/constants.dart';
import 'package:fashionstore/presentations/address/add_address.dart';
import 'package:fashionstore/widgets/appbar.dart';
import 'package:fashionstore/widgets/main_heading_widget.dart';

import 'widget/address_widget.dart';
import 'widget/price_text_widget.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({
    Key? key,
    required this.totalPrice,
    required this.totalCount,
  }) : super(key: key);
  final String totalPrice;
  final String totalCount;

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  int selectedPaymentIndex = 0;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    String email = FirebaseAuth.instance.currentUser!.email!;
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
              StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('address')
                    .where('email', isEqualTo: email)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final List<DocumentSnapshot> documents =
                        snapshot.data!.docs;

                    return documents.isNotEmpty
                        ? ListView.builder(
                            shrinkWrap: true,
                            itemCount: documents.length,
                            itemBuilder: (context, index) {
                              log(documents.length.toString());
                              return AddressWidget(
                                name: documents[index].get('name'),
                                address: documents[index].get('address'),
                                pincode: documents[index].get('pincode'),
                                state: documents[index].get('state'),
                                city: documents[index].get('city'),
                                phone: documents[index].get('phone'),
                                id: documents[index].get('id'),
                                email: documents[index].get('email'),
                              );
                            },
                          )
                        : const Padding(
                            padding: EdgeInsets.symmetric(vertical: 250.0),
                            child: Center(
                              child: Text('Address Is Not Added'),
                            ),
                          );
                  } else if (snapshot.hasError) {
                    Text('Error: ${snapshot.error}');
                    log(snapshot.error.toString());
                  } else if (snapshot.connectionState ==
                      ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  }
                  return Center(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AddNewAddresScreen(
                                fromCheckOut: true,
                              ),
                            ));
                      },
                      child: Container(
                        width: size.width * 0.9,
                        height: size.height * 0.300,
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
                            left:
                                BorderSide(color: Colors.white, width: 1), // Ad
                          ),
                        ),
                        child: const Center(
                            child: Text(
                          "Add Address",
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        )),
                      ),
                    ),
                  );
                },
              ),
              khieght10,
              Material(
                elevation: 12,
                borderRadius: const BorderRadius.all(Radius.circular(20)),
                shadowColor: Colors.black,
                child: Container(
                  width: double.infinity,
                  height: size.height * 0.18,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  child: Padding(
                    padding:
                        const EdgeInsets.only(right: 16, left: 16, top: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const PriceTextWidget(
                          text: 'Price Details :',
                          size: 22,
                        ),
                        khieght5,
                        Row(
                          children: [
                            PriceTextWidget(
                              text: 'MRP (${widget.totalCount} item)',
                            ),
                            const Spacer(),
                            Text(
                              '₹ ${int.parse(widget.totalPrice)}',
                              style: const TextStyle(
                                  fontSize: 18, color: Colors.grey),
                            ),
                          ],
                        ),
                        khieght5,
                        const Row(
                          children: [
                            PriceTextWidget(
                              text: 'Shipping',
                            ),
                            Spacer(),
                            Text(
                              'Free',
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.green,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        khieght5,
                        Row(
                          children: [
                            const PriceTextWidget(
                              text: 'You Pay',
                              size: 20,
                            ),
                            const Spacer(),
                            Text(
                              '₹ ${int.parse(widget.totalPrice)} ',
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              khieght10,
              const PriceTextWidget(
                text: 'Select Payment Method :',
                size: 22,
              ),
              Column(
                children: List.generate(
                  2,
                  (index) => GestureDetector(
                    onTap: () => setState(() {
                      selectedPaymentIndex = index;
                    }),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(
                              10.0), // set the border radius to 12.0
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          child: ListTile(
                            leading: CircleAvatar(
                              radius: 30,
                              backgroundColor: Colors.grey[200],
                              child: Padding(
                                padding: const EdgeInsets.all(0.0),
                                child: index != 0
                                    ? Image.asset(paymentIcons[index])
                                    : Image.asset(paymentIcons[index]),
                              ),
                            ),
                            title: Text(
                              paymentTitles[index],
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            trailing: Radio(
                              value: selectedPaymentIndex == index,
                              groupValue: true,
                              onChanged: (value) {
                                setState(() {
                                  selectedPaymentIndex = index;
                                });
                              },
                              activeColor: Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
