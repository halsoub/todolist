import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PostDataProvider extends ChangeNotifier {
  bool _isLoading = false;
  String? _errorMessage;
  Map<String, dynamic>? _postResult;

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  Map<String, dynamic>? get postResult => _postResult;

  Future<void> postData(String title) async {
    _isLoading = true;
    _errorMessage = null;
    _postResult = null;
    notifyListeners();

    final url = Uri.parse('https://jsonplaceholder.typicode.com/todos');
    final headers = {'Content-Type': 'application/json'};
    final bodyData = jsonEncode({'title': title, 'userId': 1});

    try {
      final response = await http.post(url, headers: headers, body: bodyData);

      if (response.statusCode == 201) {
        _postResult = jsonDecode(response.body);
      } else {
        _errorMessage = 'Failed to post data. Status code: ${response.statusCode}';
        print('Error posting data: ${response.body}');
      }
    } catch (error) {
      _errorMessage = 'Error during API request: $error';
      print('API request error: $error');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
