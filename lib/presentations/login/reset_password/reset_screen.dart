import 'dart:developer';
import 'package:fashionstore/core/constants.dart';
import 'package:fashionstore/presentations/login/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../widgets/logo.dart';
import '../../../widgets/snackbar.dart';

class ResetScreen extends StatelessWidget {
  ResetScreen({super.key});

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var height = size.height;
    var width = size.width;
    return SafeArea(
        child: Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Logo(),
                khieght60,
                Text(
                  'Reset Password',
                  style: GoogleFonts.poppins(
                    textStyle: const TextStyle(
                      letterSpacing: .5,
                      fontSize: 25,
                      color: Colors.black,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                khieght10,
                Text(
                  'Please Enter Your Email To Reset',
                  style: GoogleFonts.poppins(
                    textStyle: const TextStyle(
                      letterSpacing: .5,
                      fontSize: 14,
                      color: Colors.black45,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                khieght20,
                Text(
                  'Email',
                  style: GoogleFonts.poppins(
                    textStyle: const TextStyle(
                      letterSpacing: .5,
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                khieght20,
                SizedBox(
                  height: height / 16,
                  child: TextFormField(
                    controller: emailController,
                    validator: (value) {
                      if (value!.isEmpty ||
                          !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                              .hasMatch(value)) {
                        return "Enter Valid Email";
                      } else {
                        return null;
                      }
                    },
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      hintText: 'Enter email here',
                    ),
                  ),
                ),
                khieght30,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(
                              horizontal: width / 2.80, vertical: height / 50),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0)),
                          backgroundColor: Colors.black,
                          foregroundColor: Colors.white,
                        ),
                        onPressed: () async {
                          if (formKey.currentState!.validate()) {
                            log('validation success');
                            await FirebaseAuth.instance
                                .sendPasswordResetEmail(
                                    email: emailController.text)
                                .then((value) {
                              log('Reset Success');
                              alertSnackbar(context, 'Check Your Email');
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const LogIn(),
                                  )).onError((error, stackTrace) {
                                alertSnackbar(
                                    context, 'Error: ${error.toString()}');
                                log('Error: ${error.toString()}');
                              });
                            });
                          }
                        },
                        child: Text(
                          'Submit',
                          style: GoogleFonts.poppins(
                            textStyle: const TextStyle(
                              letterSpacing: .5,
                              fontSize: 14,
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        )),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    ));
  }
}

TextEditingController emailController = TextEditingController();
TextEditingController passwordController = TextEditingController();
