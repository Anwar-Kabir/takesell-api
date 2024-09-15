import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class DataProvider with ChangeNotifier {
  List<dynamic> _sliders = [];
  List<dynamic> _featuredCategories = [];
  List<dynamic> _todaysDeals = [];
  List<dynamic> _featuredProducts = [];

  List<dynamic> get sliders => _sliders;
  List<dynamic> get featuredCategories => _featuredCategories;
  List<dynamic> get todaysDeals => _todaysDeals;
  List<dynamic> get featuredProducts => _featuredProducts;

  Future<void> fetchSliders() async {
    final url = Uri.parse('https://www.beta.takesell.com.bd/api/v2/sliders');
    final response = await http.get(url);
    _sliders = json.decode(response.body);
    notifyListeners();
  }

  Future<void> fetchFeaturedCategories() async {
    final url = Uri.parse(
        'https://www.beta.takesell.com.bd/api/v2/categories/featured');
    final response = await http.get(url);
    _featuredCategories = json.decode(response.body);
    notifyListeners();
  }

  Future<void> fetchTodaysDeal() async {
    final url = Uri.parse(
        'https://www.beta.takesell.com.bd/api/v2/products/todays-deal');
    final response = await http.get(url);
    _todaysDeals = json.decode(response.body);
    notifyListeners();
  }

  Future<void> fetchFeaturedProducts() async {
    final url =
        Uri.parse('https://www.beta.takesell.com.bd/api/v2/products/featured');
    final response = await http.get(url);
    _featuredProducts = json.decode(response.body);
    notifyListeners();
  }
}
