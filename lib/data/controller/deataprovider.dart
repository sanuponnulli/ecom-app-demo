import 'dart:convert';
import 'dart:developer';

import 'package:assignmentecom/data/hive/hiveservices.dart';
import 'package:assignmentecom/data/repo/repo.dart';
import 'package:assignmentecom/models/fakedatamodel.dart';
import 'package:flutter/material.dart';

class MyDataProvider extends ChangeNotifier {
  final MyRepository _repository;
  final HiveService _hiveService = HiveService();

  MyDataProvider({required MyRepository repository}) : _repository = repository;

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  bool iserror = false;
  bool get error => iserror;

  List<FakeModel> _data = [];
  List<FakeModel> get data => _data;

  List<CartItem> _cart = [];
  List<CartItem> get cart => _cart;

  Future<void> fetchData() async {
    _isLoading = true;
    notifyListeners();

    try {
      final response = await _repository.fetchData();

      if (response.statusCode == 200) {
        final jsonList = response.body;
        final decodedList = json.decode(jsonList) as List<dynamic>;
        _data = decodedList.map((e) => FakeModel.fromJson(e)).toList();
        log("REPO");
      } else {
        throw Exception('Failed to fetch data: ${response.statusCode}');
      }
    } catch (e) {
      iserror = true;
      log('in provider Error fetching data: $e');
      // Handle error
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> saveToCart(FakeModel item, int qty) async {
    try {
      await _hiveService.saveToCart(CartItem(item, 1));
      notifyListeners();
    } catch (e) {
      log('Error saving to cart: $e');
      // Handle error
    }
  }

  Future<void> updateQuantityByOne(int index) async {
    try {
      final cartItem = _cart[index];

      final currentQuantity = cartItem.quantity;
      final newQuantity = currentQuantity + 1;
      await _hiveService
          .updateCartItemQuantity(index, newQuantity)
          .then((value) => fetchData());
      notifyListeners();
    } catch (e) {
      log('Error updating quantity: $e');
      // Handle error
    }
  }

  Future<void> deleteQuantityByOne(int index) async {
    try {
      final cartItem = _cart[index];
      final currentQuantity = cartItem.quantity;
      final newQuantity = currentQuantity - 1;
      newQuantity == 0
          ? await _hiveService
              .deleteFromCart(index)
              .then((value) => getCartItems())
          : await _hiveService
              .updateCartItemQuantity(index, newQuantity)
              .then((value) => getCartItems());
      notifyListeners();
    } catch (e) {
      log('Error updating quantity: $e');
      // Handle error
    }
  }

  Future<void> getCartItems() async {
    try {
      final items = await _hiveService.getCartItems();
      _cart = items.cast<CartItem>();
      notifyListeners();
    } catch (e) {
      log('Error getting cart items: $e');
      // Handle error
    }
  }

  Future<void> deleteFromCart(CartItem item) async {
    log("deletefromcart");
    try {
      final index = _cart.indexOf(item);
      if (index != -1) {
        await _hiveService
            .deleteFromCart(index)
            .then((value) => getCartItems());
        notifyListeners();
        log("deletefromcart");
      }
    } catch (e) {
      log('Error deleting from cart: $e');
      // Handle error
    }
    notifyListeners();
  }
}
