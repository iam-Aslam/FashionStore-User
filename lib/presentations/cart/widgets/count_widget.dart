import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class CountWidget extends StatelessWidget {
  final String cartId;
  final int initialQuantity;

  const CountWidget({
    Key? key,
    required this.cartId,
    required this.initialQuantity,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ValueNotifier<int> quantity = ValueNotifier<int>(initialQuantity);
    void updateQuantity() {
      final quantityRef =
          FirebaseFirestore.instance.collection('cart').doc(cartId);
      quantityRef.update({'quantity': quantity.value});
      log(quantity.value.toString());
    }

    void reduceCount() {
      if (quantity.value > 1) {
        quantity.value--;
        updateQuantity();
      }
    }

    void addCount() {
      quantity.value++;
      updateQuantity();
    }

    final size = MediaQuery.of(context).size;

    return SizedBox(
      width: size.width * 0.2,
      child: ValueListenableBuilder<int>(
        valueListenable: quantity,
        builder: (BuildContext context, int value, Widget? child) {
          return Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IgnorePointer(
                ignoring: value <= 1,
                child: GestureDetector(
                  onTap: reduceCount,
                  child: const Icon(
                    CupertinoIcons.minus,
                    size: 15,
                  ),
                ),
              ),
              Text(
                value.toString(),
                style: const TextStyle(fontSize: 20),
              ),
              GestureDetector(
                onTap: addCount,
                child: const Icon(
                  CupertinoIcons.add,
                  size: 15,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
