import 'dart:developer';
import 'package:fashionstore/core/constants.dart';
import 'package:fashionstore/presentations/login/reset_password/reset_screen.dart';
import 'package:fashionstore/presentations/signup/signup.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../../widgets/logo.dart';
import '../../widgets/snackbar.dart';
import '../home/home_screen.dart';

class LogIn extends StatefulWidget {
  const LogIn({super.key});

  @override
  State<LogIn> createState() => _LogInState();
}

TextEditingController emailController = TextEditingController();
TextEditingController passwordController = TextEditingController();
bool passenable = true;

class _LogInState extends State<LogIn> {
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
                    'Welcome!',
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
                    'please login or sign up to continue our app',
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
                  TextFormField(
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
                    decoration: InputDecoration(
                      labelText: 'Enter Email',
                      labelStyle: GoogleFonts.poppins(
                        textStyle: const TextStyle(
                          letterSpacing: .5,
                          fontSize: 18,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                  khieght10,
                  TextFormField(
                    controller: passwordController,
                    obscureText: passenable,
                    enableSuggestions: false,
                    autocorrect: false,
                    validator: (value) {
                      if (value!.isEmpty || value.length < 6) {
                        return "Enter Valid Password";
                      } else {
                        return null;
                      }
                    },
                    decoration: InputDecoration(
                      labelText: 'Password',
                      labelStyle: GoogleFonts.poppins(
                        textStyle: const TextStyle(
                          letterSpacing: .5,
                          fontSize: 18,
                          color: Colors.black,
                        ),
                      ),
                      suffix: IconButton(
                        onPressed: () {
                          setState(() {
                            if (passenable) {
                              passenable = false;
                            } else {
                              passenable = true;
                            }
                          });
                        },
                        icon: Icon(passenable == true
                            ? Icons.remove_red_eye
                            : Icons.lock_outline),
                      ),
                    ),
                  ),
                  khieght5,
                  Row(
                    children: [
                      const Spacer(),
                      InkWell(
                        onTap: () {
                          log('Forgot Password');
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ResetScreen(),
                              ));
                        },
                        child: Text(
                          'Forgot Password?',
                          style: GoogleFonts.poppins(
                            textStyle: const TextStyle(
                              fontSize: 15,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  khieght20,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(
                                horizontal: width / 2.65,
                                vertical: height / 50),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.0)),
                            backgroundColor: Colors.black,
                            foregroundColor: Colors.white,
                          ),
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              log('validation success');
                              FirebaseAuth.instance
                                  .signInWithEmailAndPassword(
                                      email: emailController.text,
                                      password: passwordController.text)
                                  .then((value) {
                                log('Login success');
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const HomePage(),
                                    )).onError((error, stackTrace) {
                                  Fluttertoast.showToast(
                                    msg: '${error.toString()}',
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.BOTTOM,
                                    timeInSecForIosWeb: 1,
                                    backgroundColor: Colors.black,
                                    textColor: Colors.white,
                                  );
                                });
                              });
                            }
                          },
                          child: Text(
                            'Login',
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
                  khieght10,
                  Center(
                    child: Text(
                      'or',
                      style: GoogleFonts.poppins(
                        textStyle: const TextStyle(
                          letterSpacing: .5,
                          fontSize: 14,
                          color: Colors.black,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                  khieght10,
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(
                          horizontal: width / 8, vertical: height / 100),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0)),
                      backgroundColor: Colors.black,
                      foregroundColor: Colors.white,
                    ),
                    onPressed: () {
                      loginWithGoogle();
                    },
                    child: SizedBox(
                      width: width / 1,
                      height: height / 20,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          SizedBox(
                              width: width / 20,
                              height: height / 60,
                              child: Image.network(
                                  'http://pngimg.com/uploads/google/google_PNG19635.png',
                                  fit: BoxFit.cover)),
                          SizedBox(
                            width: width / 50,
                          ),
                          Text(
                            'Continue with Google',
                            style: GoogleFonts.poppins(
                              textStyle: const TextStyle(
                                fontSize: 14,
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  khieght20,
                  Center(
                    child: InkWell(
                      onTap: () {
                        log('Riderect to signup page');
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const SignUp(),
                            ));
                      },
                      child: Text(
                        'Create an Account',
                        style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                            letterSpacing: .5,
                            fontSize: 14,
                            color: Colors.blue[900],
                          ),
                        ),
                      ),
                    ),
                  ),
                  khieght10,
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  loginWithGoogle() async {
    final GoogleSignIn googleSignIn = GoogleSignIn();
    final googleUser = await googleSignIn.signIn();
    if (googleUser == null) return;
    GoogleSignInAuthentication googleAuth = await googleUser.authentication;
    AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    await FirebaseAuth.instance.signInWithCredential(credential).then((value) {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const HomePage(),
          )).onError((error, stackTrace) {
        alertSnackbar(context, 'Error: ${error.toString()}');
        log("Error ${error.toString()}");
      });
    });
  }
}
