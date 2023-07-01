import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'card_completed.dart';

class DeliveredWidget extends StatelessWidget {
  const DeliveredWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final email = FirebaseAuth.instance.currentUser!.email;
    var size = MediaQuery.of(context).size;

    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('orders')
          .where('email', isEqualTo: email)
          .where('active', isEqualTo: false)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final List<DocumentSnapshot> documents = snapshot.data!.docs;
          return documents.isNotEmpty
              ? ListView.separated(
                  itemCount: documents.length,
                  separatorBuilder: (context, index) => const SizedBox(
                    height: 8,
                  ),
                  itemBuilder: (context, index) {
                    return CardCompleted(
                      totalPrice: documents[index].get('totalprice'),
                      productId: documents[index].get('productid').toString(),
                    );
                  },
                )
              : SizedBox(
                  height: size.height * 0.8,
                  child: const Center(
                    child: Text(
                      "You have no Delivered Products",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                );
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return SizedBox(
            height: size.height * 0.8,
            child: const Center(
              child: Text(
                "You have no active!",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          );
        }
      },
    );
  }
}
