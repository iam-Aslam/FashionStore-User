import 'dart:developer';
import 'package:fashionstore/presentations/account/account_screen.dart';
import 'package:fashionstore/presentations/profile/profile_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class HeadWidget extends StatelessWidget {
  const HeadWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CircleAvatar(
          backgroundColor: Colors.black,
          child: IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ScreenAccount(),
                    ));
              },
              icon: const Icon(CupertinoIcons.settings_solid)),
        ),
        InkWell(
          onTap: () {
            log('Go to Profile');
            Navigator.push(
              context,
              PageTransition(
                type: PageTransitionType.rightToLeft,
                child: const ProfileScreen(),
              ),
            );
          },
          child: const CircleAvatar(
            backgroundColor: Colors.black,
            radius: 20,
            backgroundImage: NetworkImage(
                'https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=880&q=80'),
          ),
        )
      ],
    );
  }
}
