import 'package:flutter/foundation.dart';

class CartProvider with ChangeNotifier {
  int _totalPrice = 0;

  int get totalPrice => _totalPrice;

  void updateTotalPrice(int newTotalPrice) {
    _totalPrice = newTotalPrice;
    notifyListeners();
  }
}
