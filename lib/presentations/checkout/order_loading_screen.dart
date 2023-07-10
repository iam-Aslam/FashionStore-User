import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:checkmark/checkmark.dart';
import 'package:fashionstore/model/functions.dart';
import 'package:fashionstore/presentations/home/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class OrderLoadingScreen extends StatefulWidget {
  const OrderLoadingScreen({
    super.key,
  });

  @override
  State<OrderLoadingScreen> createState() => _OrderLoadingScreenState();
}

class _OrderLoadingScreenState extends State<OrderLoadingScreen> {
  final email = FirebaseAuth.instance.currentUser!.email;
  bool checked = false;
  @override
  void initState() {
    placeOrderAndDeleteCartItems(email!);
    delayChecked();
    super.initState();
  }

  delayChecked() async {
    await Future.delayed(
      const Duration(milliseconds: 1),
      () {
        setState(() {
          checked = true;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    navigateToHome(context);
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 100,
              width: 100,
              child: CheckMark(
                active: checked,
                curve: Curves.decelerate,
                duration: const Duration(milliseconds: 700),
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            SizedBox(
              width: 300,
              child: DefaultTextStyle(
                style: GoogleFonts.comfortaa(
                  fontSize: 30.0,
                  color: Colors.black,
                ),
                child: AnimatedTextKit(
                  totalRepeatCount: 1,
                  animatedTexts: [
                    TyperAnimatedText('Order was Placed'),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

navigateToHome(BuildContext context) {
  Future.delayed(
      const Duration(milliseconds: 1500),
      () => Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) => const HomePage(),
            ),
            (Route<dynamic> route) => false,
          ));
}
