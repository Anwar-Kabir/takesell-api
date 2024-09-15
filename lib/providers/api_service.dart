import 'package:http/http.dart' as http;
import 'package:rest_api/Model/category_product.dart';
import 'package:rest_api/Model/featured_category.dart';
import 'dart:convert';

import 'package:rest_api/Model/slider_model.dart';
import 'package:rest_api/Model/todays_deal.dart';

class ApiService {
  static const String baseUrl = "https://www.beta.takesell.com.bd/api/v2";

  // Fetch sliders
  Future<List<SliderModel>> fetchSliders() async {
    final response = await http.get(Uri.parse("$baseUrl/sliders"));
    if (response.statusCode == 200) {
      final data = json.decode(response.body)['data'];
      return data
          .map<SliderModel>((json) => SliderModel.fromJson(json))
          .toList();
    } else {
      throw Exception('Failed to load sliders');
    }
  }

  // Fetch featured categories
  Future<List<FeaturedCategory>> fetchFeaturedCategories() async {
    final response = await http.get(Uri.parse("$baseUrl/categories/featured"));
    if (response.statusCode == 200) {
      final data = json.decode(response.body)['data'];
      return data
          .map<FeaturedCategory>((json) => FeaturedCategory.fromJson(json))
          .toList();
    } else {
      throw Exception('Failed to load featured categories');
    }
  }

  // Fetch today's deals
  Future<List<TodaysDeal>> fetchTodaysDeals() async {
    final response = await http.get(Uri.parse("$baseUrl/products/todays-deal"));
    if (response.statusCode == 200) {
      final data = json.decode(response.body)['data'];
      return data.map<TodaysDeal>((json) => TodaysDeal.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load today\'s deals');
    }
  }

  // Fetch featured products
  Future<List<TodaysDeal>> fetchFeaturedProducts() async {
    final response = await http.get(Uri.parse("$baseUrl/products/featured"));
    if (response.statusCode == 200) {
      final data = json.decode(response.body)['data'];
      return data.map<TodaysDeal>((json) => TodaysDeal.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load featured products');
    }
  }

  // Fetch category-wise products
  Future<List<Product>> fetchCategoryProducts(int categoryId) async {
    final url =
        'https://www.beta.takesell.com.bd/api/v2/products/category/$categoryId';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final List<dynamic> productList = json.decode(response.body)['data'];
      return productList.map((json) => Product.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load products');
    }
  }
}
