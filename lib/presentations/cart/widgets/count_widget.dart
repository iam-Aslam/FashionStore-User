import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fashionstore/provider/cart_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class CountWidget extends StatefulWidget {
  final String cartId;
  final int initialQuantity;

  const CountWidget({
    Key? key,
    required this.cartId,
    required this.initialQuantity,
  }) : super(key: key);

  @override
  State<CountWidget> createState() => _CountWidgetState();
}

class _CountWidgetState extends State<CountWidget> {
  late int quantity;
  @override
  void initState() {
    super.initState();
    quantity = widget.initialQuantity;
  }

  void reduceCount() {
    if (quantity > 1) {
      setState(() {
        quantity--;
      });

      // Update the quantity in the cart using the cartId
      // ...
      updateQuantity();

      final cartProvider = Provider.of<CartProvider>(context, listen: false);
      // Calculate the price change based on the item's price and quantity
      int priceChange = getPriceChange();

      // Update the total price in the cart provider
      cartProvider.updateTotalPrice(cartProvider.totalPrice - priceChange);
    }
  }

  void addCount() {
    setState(() {
      quantity++;
    });

    // Update the quantity in the cart using the cartId
    // ...
    updateQuantity();

    final cartProvider = Provider.of<CartProvider>(context, listen: false);
    // Calculate the price change based on the item's price and quantity
    int priceChange = getPriceChange();

    // Update the total price in the cart provider
    cartProvider.updateTotalPrice(cartProvider.totalPrice + priceChange);
  }

  int getPriceChange() {
    // Retrieve the item's price from the database or other source
    int itemPrice = 0; // Replace with the actual item's price

    // Calculate the price change based on the item's price and quantity
    int priceChange = (quantity - widget.initialQuantity) * itemPrice;

    return priceChange;
  }

  void updateQuantity() {
    final quantityRef =
        FirebaseFirestore.instance.collection('cart').doc(widget.cartId);
    quantityRef.update({'quantity': quantity});
  }

  @override
  Widget build(BuildContext context) {
    // final ValueNotifier<int> quantity =
    //     ValueNotifier<int>(widget.initialQuantity);
    // void updateQuantity() {
    //   final quantityRef =
    //       FirebaseFirestore.instance.collection('cart').doc(widget.cartId);
    //   quantityRef.update({'quantity': quantity.value});
    // }

    // void reduceCount() {
    //   if (quantity.value > 1) {
    //     quantity.value--;
    //     updateQuantity();
    //   }
    // }

    // void addCount() {
    //   quantity.value++;
    //   updateQuantity();
    // }

    final size = MediaQuery.of(context).size;

    return SizedBox(
      width: size.width * 0.2,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          IgnorePointer(
            ignoring: quantity <= 1,
            child: GestureDetector(
              onTap: reduceCount,
              child: const Icon(
                CupertinoIcons.minus,
                size: 15,
              ),
            ),
          ),
          Text(
            quantity.toString(),
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
      ),
    );
  }
}
