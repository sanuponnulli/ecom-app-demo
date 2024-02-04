import 'dart:convert';
import 'dart:developer';

import 'package:assignmentecom/data/repo/repo.dart';
import 'package:assignmentecom/models/fakedatamodel.dart';
import 'package:flutter/material.dart';

class MyDataProvider extends ChangeNotifier {
  final MyRepository _repository;

  MyDataProvider({required MyRepository repository}) : _repository = repository;

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  bool iserror = false;
  bool get error => iserror;

  List<FakeModel> _data = [];
  List<FakeModel> get data => _data;

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
}
