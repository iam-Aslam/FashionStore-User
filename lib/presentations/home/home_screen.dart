import 'dart:developer';

import 'package:fashionstore/presentations/login/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Center(
        child: IconButton(
            onPressed: () {
              FirebaseAuth.instance.signOut().then((value) {
                log('LogOut success');
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LogIn(),
                    ));
              }).onError((error, stackTrace) {
                log('Error: ${error.toString()}');
              });
            },
            icon: const Icon(Icons.logout_outlined)),
      ),
    ));
  }
}
