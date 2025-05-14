import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:todolist/model/task_model.dart';

class TaskProvider with ChangeNotifier {
  List<Todos> _tasks = [];
  bool _isLoading = false;
  String? _errorMessage;
  List<Todos> get task => _tasks;

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  List<Todos> get tasks => _tasks;

  Future<void> fetchAllTask() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();
    try {
      final response = await http.get(Uri.parse("https://jsonplaceholder.typicode.com/todos"));
      if (response.statusCode == 200) {
        List<dynamic> jsonData = json.decode(response.body);
        _tasks = jsonData.map((item) => Todos.fromJson(item)).toList();
      } else {
        _errorMessage = "Failed to load products";
      }
    } catch (error) {
      _errorMessage = "Error: $error";
    }
    _isLoading = false;
    notifyListeners();
  }
}
