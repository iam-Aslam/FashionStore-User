import 'dart:developer';
import 'package:fashionstore/presentations/address/address_screen.dart';
import 'package:fashionstore/presentations/orders/orders_screen.dart';
import 'package:fashionstore/presentations/profile/profile_screen.dart';
import 'package:fashionstore/widgets/show_bottom.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fashionstore/core/constants.dart';
import 'package:fashionstore/widgets/appbar.dart';
import 'package:fashionstore/widgets/main_heading_widget.dart';
import 'package:page_transition/page_transition.dart';
import 'widgets/account_tile_widget.dart';
import 'widgets/markup_file.dart';

class ScreenAccount extends StatelessWidget {
  const ScreenAccount({super.key});
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SafeArea(
        child: Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 12.0, right: 10, top: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Appbar(goBack: false),
            khieght10,
            const MainHeading(
              text: 'Account',
            ),
            khieght20,
            IntrinsicHeight(
              child: Container(
                  width: size.width * 0.92,
                  height: size.height * 0.37,
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(20)),
                      border: Border.all(color: Colors.grey, width: 1.5)),
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      children: [
                        AccountTile(
                          name: 'Personal Details',
                          icon: CupertinoIcons.person_fill,
                          voidCallback: () {
                            log('Hello I am personal details');
                            Navigator.push(
                              context,
                              PageTransition(
                                type: PageTransitionType.rightToLeft,
                                child: const ProfileScreen(),
                              ),
                            );
                          },
                        ),
                        AccountTile(
                          name: 'My Orders',
                          icon: CupertinoIcons.bag,
                          voidCallback: () {
                            Navigator.push(
                                context,
                                PageTransition(
                                    type: PageTransitionType.rightToLeft,
                                    child: const OrderScreen()));
                          },
                        ),
                        AccountTile(
                          name: 'Address',
                          icon: Icons.local_shipping_rounded,
                          voidCallback: () {
                            Navigator.push(
                              context,
                              PageTransition(
                                type: PageTransitionType.rightToLeft,
                                child: const AddressScreen(),
                              ),
                            );
                            log('Hello I am Your shipping Address');
                          },
                        ),
                        AccountTile(
                          name: 'Privacy and Policy',
                          icon: Icons.privacy_tip_outlined,
                          voidCallback: () {
                            log('Hello I am Your privacy and policy');
                            showDialog(
                                context: context,
                                builder: (builder) {
                                  return SettingsMenuPop(
                                      mdFileName: 'privacy.md');
                                });
                          },
                        ),
                        AccountTile(
                          name: 'Terms and Conditions',
                          icon: Icons.sticky_note_2_rounded,
                          voidCallback: () {
                            log('Hello I am terms and conditions');
                            showDialog(
                                context: context,
                                builder: (builder) {
                                  return SettingsMenuPop(
                                      mdFileName: 'terms.md');
                                });
                          },
                        ),
                      ],
                    ),
                  )),
            ),
            const Spacer(),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(
                      horizontal: size.width / 3.5, vertical: size.height / 50),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0)),
                  backgroundColor: Colors.black,
                  foregroundColor: Colors.white,
                ),
                onPressed: () async {
                  showBottomModalSheet(context);
                },
                child: Row(
                  children: [
                    const Icon(Icons.logout_rounded),
                    kwidth10,
                    Text(
                      'Log Out',
                      style: GoogleFonts.poppins(
                        textStyle: const TextStyle(
                          letterSpacing: .5,
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                )),
          ],
        ),
      ),
    ));
  }
}
