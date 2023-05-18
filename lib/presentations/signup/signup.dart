import 'package:fashionstore/presentations/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/constants.dart';
import '../../widgets/logo.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  @override
  Widget build(BuildContext context) {
    bool? checkbox = false;
    return SafeArea(
        child: Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Logo(),
              khieght60,
              Text(
                'Sign Up',
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
                'Create a new account',
                style: GoogleFonts.poppins(
                  textStyle: const TextStyle(
                    letterSpacing: .5,
                    fontSize: 14,
                    color: Colors.black45,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              khieght40,
              Text(
                'User Name',
                style: GoogleFonts.poppins(
                  textStyle: const TextStyle(
                    letterSpacing: .5,
                    fontSize: 20,
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              khieght10,
              SizedBox(
                height: 25,
                child: TextFormField(
                  decoration: InputDecoration(
                    suffixIcon: const Icon(
                      Icons.info,
                      size: 15,
                      color: Colors.red,
                    ),
                    hintText: 'Name',
                    hintStyle: GoogleFonts.poppins(
                      textStyle: const TextStyle(
                        letterSpacing: .5,
                        fontSize: 12,
                        color: Colors.black54,
                      ),
                    ),
                  ),
                ),
              ),
              khieght10,
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
              khieght10,
              SizedBox(
                height: 25,
                child: TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    suffixIcon: const Icon(
                      Icons.info,
                      size: 15,
                      color: Colors.red,
                    ),
                    hintText: 'Enter email here',
                    hintStyle: GoogleFonts.poppins(
                      textStyle: const TextStyle(
                        letterSpacing: .5,
                        fontSize: 12,
                        color: Colors.black54,
                      ),
                    ),
                  ),
                ),
              ),
              khieght10,
              Text(
                'Password',
                style: GoogleFonts.poppins(
                  textStyle: const TextStyle(
                    letterSpacing: .5,
                    fontSize: 20,
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              khieght10,
              SizedBox(
                height: 25,
                child: TextFormField(
                  decoration: InputDecoration(
                    hintText: '********',
                    hintStyle: GoogleFonts.poppins(
                      textStyle: const TextStyle(
                        letterSpacing: .5,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.black54,
                      ),
                    ),
                    suffixIcon: const Icon(
                      Icons.hide_source_rounded,
                      size: 15,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
              khieght10,
              Text(
                'Confirm Password',
                style: GoogleFonts.poppins(
                  textStyle: const TextStyle(
                    letterSpacing: .5,
                    fontSize: 20,
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              khieght10,
              SizedBox(
                height: 25,
                child: TextFormField(
                  decoration: InputDecoration(
                      suffixIcon: const Icon(
                        Icons.hide_source_rounded,
                        size: 15,
                        color: Colors.black,
                      ),
                      hintText: '********',
                      hintStyle: GoogleFonts.poppins(
                        textStyle: const TextStyle(
                          letterSpacing: .5,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Colors.black54,
                        ),
                      )),
                ),
              ),
              Row(
                children: [
                  SizedBox(
                    height: 5,
                    width: 5,
                    child: Checkbox(
                      value: checkbox,
                      activeColor: Colors.black,
                      onChanged: (value) {
                        setState(() {
                          checkbox = value;
                        });
                      },
                    ),
                  ),
                  kwidth10,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      khieght10,
                      Text('By creating an account you have to agree',
                          maxLines: 2,
                          style: GoogleFonts.poppins(
                            textStyle: const TextStyle(
                              letterSpacing: .5,
                              fontSize: 12,
                              color: Colors.black45,
                              fontWeight: FontWeight.w500,
                            ),
                          )),
                      Text('with our terms & conditions',
                          maxLines: 2,
                          style: GoogleFonts.poppins(
                            textStyle: const TextStyle(
                              letterSpacing: .5,
                              fontSize: 12,
                              color: Colors.black45,
                              fontWeight: FontWeight.w500,
                            ),
                          )),
                    ],
                  ),
                ],
              ),
              khieght20,
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 144.0, vertical: 15.0),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0)),
                    backgroundColor: Colors.black,
                    foregroundColor: Colors.white,
                  ),
                  onPressed: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const HomePage(),
                        ));
                  },
                  child: Text(
                    'Create',
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
        ),
      ),
    ));
  }
}
