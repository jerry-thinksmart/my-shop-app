import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Auth with ChangeNotifier {
  Future<void> signUp(String email, String password) async {
    final url = Uri.parse(
      'https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=AIzaSyDLK3eAE-CHytBArmzlQvAawAll_1xa3fk',
    );

    try {
      final requestBody = json.encode({
        'email': email,
        'password': password,
        'returnSecureToken': true,
      });

      await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: requestBody,
      );
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }
}
