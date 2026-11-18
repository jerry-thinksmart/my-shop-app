import 'package:flutter/material.dart';
import '../model/carts.dart';

class Cart with ChangeNotifier {
  final List<Item> _items = [];

  List<Item> get items => _items;

  void addCart(Item item) {
    _items.add(item);

    notifyListeners();
  }

  void removeCart([Item? item]) {
    if (item == null) {
      _items.clear();
    } else {
      _items.remove(item);
    }

    notifyListeners();
  }

  void updateQuantity(Item item, int quantity) {
    item.quantity = quantity;
    notifyListeners();
  }
}
