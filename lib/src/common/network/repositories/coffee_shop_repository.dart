import 'dart:convert';

import 'package:coffee_shop/src/features/menu/data/category_data.dart';
import 'package:coffee_shop/src/features/menu/data/product_data.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CoffeeShopRepository{
  Future<CategoryData> fetchProductsByCategory(categoryData, int id) async {
    final response = await http.get(Uri.https('coffeeshop.academy.effective.band','/api/v1/products', {
      'page': '0',
      'limit': '5',
      'category': '$id',
    }));
    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonResponse = json.decode(utf8.decode(response.bodyBytes));
      debugPrint('avova1');
      return CategoryData.fromJson(categoryData, jsonResponse);
    } else {
      throw Exception('Failed to load product dta');
    }
  }

  Future<List<CategoryData>> fetchCategories() async {
  final response = await http.get(Uri.https('coffeeshop.academy.effective.band','/api/v1/products/categories'));
  
  if (response.statusCode == 200) {
    final Map<String, dynamic> jsonResponse = json.decode(utf8.decode(response.bodyBytes));
    List<dynamic> categoriesData = jsonResponse['data'];
    
    List<CategoryData> categories = [];
    for (var categoryData in categoriesData) {
      var id = categoryData['id'];
      CategoryData category = await fetchProductsByCategory(categoryData, id);
      categories.add(category);
    }

    return categories;
  } else {
    throw Exception('Failed to load category data');
  }
  }
}