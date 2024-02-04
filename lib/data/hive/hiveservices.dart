// lib/data/hive_service.dart
import 'dart:developer';

import 'package:assignmentecom/models/fakedatamodel.dart';
import 'package:hive_flutter/adapters.dart';

class HiveService {
  static final HiveService _instance = HiveService._internal();

  factory HiveService() {
    return _instance;
  }

  HiveService._internal();

  Future<void> saveToCart(CartItem item) async {
    var box = await Hive.openBox<CartItem>('cart');
    for (var storedItem in box.values) {
      if (storedItem.fakeModel == item.fakeModel) {
        log('Item already exists in cart');
        return;
      }
    }
    final temp = await box.add(item);
    log(temp.toString());
  }

  Future<List<CartItem>> getCartItems() async {
    var box = await Hive.openBox<CartItem>('cart');
    return box.values.toList();
  }

  Future<void> deleteFromCart(int index) async {
    var box = await Hive.openBox<CartItem>('cart');
    box.deleteAt(index);
  }

  Future<void> updateCartItemQuantity(int index, int newQuantity) async {
    var box = await Hive.openBox<CartItem>('cart');
    var item = box.getAt(index);
    if (item != null) {
      item.quantity = newQuantity;
      await box.putAt(index, item);
    }
  }
}
