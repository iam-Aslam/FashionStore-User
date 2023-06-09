import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fashionstore/core/strings.dart';
import 'package:fashionstore/presentations/checkout/order_loading_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fashionstore/core/constants.dart';
import 'package:fashionstore/presentations/address/add_address.dart';
import 'package:fashionstore/widgets/appbar.dart';
import 'package:fashionstore/widgets/main_heading_widget.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'widget/address_widget.dart';
import 'widget/edit_address_button.dart';
import 'widget/failure_widget.dart';
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
  bool isAddress = false;
  var razorpay = Razorpay();
  @override
  void initState() {
    razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    super.initState();
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const OrderLoadingScreen(),
        ));
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    log(response.message.toString());
    showFailure(context, "Failure", "Payment was unsuccessful");
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    log("External Wallet Selected");
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    String email = FirebaseAuth.instance.currentUser!.email!;
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding:
              const EdgeInsets.only(left: 12.0, right: 10, top: 10, bottom: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Appbar(
                goBack: true,
              ),
              const MainHeading(
                text: 'Delivery Address',
              ),
              StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('address')
                    .where('email', isEqualTo: email)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final List<DocumentSnapshot> documents =
                        snapshot.data!.docs;
                    isAddress = documents.isNotEmpty;
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
                        : EditButton(
                            name:
                                'Click Here!  to Add Address Before Confirming Order',
                            onTap: () {
                              Navigator.push(
                                context,
                                PageTransition(
                                  type: PageTransitionType.bottomToTop,
                                  child: AddNewAddresScreen(),
                                ),
                              );
                            });
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
              const Spacer(),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(
                        horizontal: size.width / 20,
                        vertical: size.height / 50),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0)),
                    backgroundColor: Colors.black,
                    foregroundColor: Colors.white,
                  ),
                  onPressed: () async {
                    if (isAddress == true) {
                      if (selectedPaymentIndex == 1) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const OrderLoadingScreen(),
                            ));
                      } else {
                        final user = FirebaseAuth.instance.currentUser;
                        Map<String, dynamic> options = {
                          'key': 'rzp_test_UHMMVsaCTOCuSf',
                          'amount': int.parse(widget.totalPrice) * 100,
                          'name': 'Fashion Store',
                          'timeout': 300,
                          'description': 'Item',
                          'prefill': {'contact': '', 'email': user!.email}
                        };
                        razorpay.open(options);
                      }
                    } else {
                      Fluttertoast.showToast(
                        msg: 'Please add an Address',
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.black,
                        textColor: Colors.white,
                      );
                    }
                  },
                  child: Row(
                    children: [
                      Text(
                        'Confirm Order',
                        style: GoogleFonts.poppins(
                          textStyle: const TextStyle(
                            letterSpacing: .5,
                            fontSize: 18,
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      const Spacer(),
                      const Icon(
                        CupertinoIcons.check_mark,
                        size: 25,
                      )
                    ],
                  )),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    razorpay.clear();
    super.dispose();
  }
}
