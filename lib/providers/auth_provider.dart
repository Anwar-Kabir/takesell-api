import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider with ChangeNotifier {
  String? _token;

  String? get token => _token;

  // Login Function
  Future<void> login(String email, String password) async {
    final url = Uri.parse('https://www.beta.takesell.com.bd/api/v2/auth/login');
    try {
      final response = await http.post(
        url,
        body: {
          'email': email,
          'password': password,
        },
      );
      final responseData = json.decode(response.body);
      if (responseData['status'] == 'success') {
        _token = responseData['access_token'];
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('token', _token!);
        notifyListeners();
      } else {
        throw Exception('Failed to login');
      }
    } catch (error) {
      rethrow;
    }
  }

  // Signup Function
  Future<void> signup(String name, String email, String password) async {
    final url =
        Uri.parse('https://www.beta.takesell.com.bd/api/v2/auth/signup');
    try {
      final response = await http.post(
        url,
        body: {
          'name': name,
          'email': email,
          'password': password,
        },
      );
      final responseData = json.decode(response.body);
      if (responseData['status'] == 'success') {
        _token = responseData['access_token'];
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('token', _token!);
        notifyListeners();
      } else {
        throw Exception('Failed to signup');
      }
    } catch (error) {
      rethrow;
    }
  }

  // Logout Function
  Future<void> logout() async {
    _token = null;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('token');
    notifyListeners();
  }

  bool get isAuthenticated {
    return _token != null;
  }

  Future<void> tryAutoLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('token')) return;
    _token = prefs.getString('token');
    notifyListeners();
  }
}
