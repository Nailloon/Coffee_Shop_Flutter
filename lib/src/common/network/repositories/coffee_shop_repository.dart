import 'dart:convert';
import 'package:coffee_shop/src/features/menu/data/category_data.dart';
import 'package:coffee_shop/src/features/menu/data/product_data.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CoffeeShopRepository{
  Future<CategoryData> fetchProductsByCategory(categoryData, int id, int limit) async {
    final response = await http.get(Uri.https('coffeeshop.academy.effective.band','/api/v1/products', {
      'page': '0',
      'limit': '$limit',
      'category': '$id',
    }));
    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonResponse = json.decode(utf8.decode(response.bodyBytes));
      debugPrint('avova1');
      return CategoryData.fromJson(categoryData, jsonResponse);
    } else {
      throw Exception('Failed to load product data');
    }
  }

  Future<List<CategoryData>> fetchCategoriesWithProducts(int limitForCategory) async {
  final response = await http.get(Uri.https('coffeeshop.academy.effective.band','/api/v1/products/categories'));
  
  if (response.statusCode == 200) {
    final Map<String, dynamic> jsonResponse = json.decode(utf8.decode(response.bodyBytes));
    List<dynamic> categoriesData = jsonResponse['data'];
    
    List<CategoryData> categories = [];
    for (var categoryData in categoriesData) {
      var id = categoryData['id'];
      CategoryData category = await fetchProductsByCategory(categoryData, id, limitForCategory);
      categories.add(category);
    }

    return categories;
  } else {
    throw Exception('Failed to load category data');
  }
  }
  
  Future<List<CategoryData>> fetchAnyProducts(int limitForProducts) async{
    final response = await http.get(Uri.https('coffeeshop.academy.effective.band', '/api/v1/products/', {
    'page': '0',
    'limit': '$limitForProducts',
  }));

  if (response.statusCode == 200) {
    var jsonData = json.decode(utf8.decode(response.bodyBytes));
    var data = jsonData['data'] as List;

    List<CategoryData> categories = [];
    
    for (var productJson in data) {
      var category = CategoryData.fromJsonWithProduct(productJson['category'], productJson);
      bool existing = false;
      for (var existingCategory in categories) {
        if (existingCategory.id == category.id) {
          existingCategory.products.addAll(category.products);
          existing = true;
          break;
        }
      }

      if (!existing) {
        categories.add(category);
      }
    }

    return categories;
  } else {
    throw Exception('Failed to load data');
  }
  }

  Future<List<CategoryData>> fetchOnlyCategories() async{
    final response = await http.get(Uri.https('coffeeshop.academy.effective.band','/api/v1/products/categories'));
    if (response.statusCode == 200) {
    final Map<String, dynamic> jsonResponse = json.decode(utf8.decode(response.bodyBytes));
    List<dynamic> categoriesData = jsonResponse['data'];
    
    List<CategoryData> categories = [];
    for (var categoryData in categoriesData) {
      CategoryData category = CategoryData(id: categoryData['id'], name: categoryData['slug'], products: []);
      categories.add(category);
    }

      return categories;
    } else {
      throw Exception('Failed to load category data');
    }
  }

  Future<ProductData> fetchProductByID(int id) async{
    final response = await http.get(Uri.https('coffeeshop.academy.effective.band', '/api/v1/products/$id',));
    if (response.statusCode == 200) {
    final Map<String, dynamic> jsonResponse = json.decode(utf8.decode(response.bodyBytes));
      debugPrint(ProductData.fromJson(jsonResponse).toString());
      return ProductData.fromJson(jsonResponse);
    } else {
      throw Exception('Failed to load category data');
    }
  }

}