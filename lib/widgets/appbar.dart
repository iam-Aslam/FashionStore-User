import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fashionstore/presentations/cart/cart_screen.dart';

class Appbar extends StatelessWidget {
  const Appbar({
    Key? key,
    required this.goBack,
  }) : super(key: key);
  final bool goBack;

  @override
  Widget build(BuildContext context) {
    String email = FirebaseAuth.instance.currentUser!.email!;
    return Row(
      children: [
        InkWell(
          onTap: () {
            goBack ? Navigator.pop(context) : null;
          },
          child: const CircleAvatar(
              radius: 20,
              backgroundImage: AssetImage('assets/images/prev.jpg')),
        ),
        const Spacer(),
        StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('cart')
              .where('email', isEqualTo: email)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting ||
                !snapshot.hasData) {
              return IconButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) {
                        return const ScreenCart();
                      },
                    ));
                  },
                  icon: const Icon(
                    CupertinoIcons.bag,
                    size: 30,
                  ));
            }
            final cartDatas = snapshot.data!.docs.toList();
            return Stack(
              children: [
                IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      CupertinoIcons.bag,
                      size: 30,
                    )),
                Positioned(
                  right: 5,
                  top: 5,
                  child: CircleAvatar(
                    backgroundColor: Colors.black,
                    radius: 9,
                    child: Text(
                      cartDatas.length.toString(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        )
      ],
    );
  }
}
