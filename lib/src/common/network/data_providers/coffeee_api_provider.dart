import 'dart:convert';
import 'package:coffee_shop/src/common/network/data_providers/interface_data_provider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

final class CoffeShopApiDataProvider implements IDataProvider {
  final String baseUrl = 'coffeeshop.academy.effective.band';
  final String apiVersion = '/api/v1/products';
  final String orderVersion = 'api/v1/orders';
  final http.Client client = http.Client();

  @override
  Future<List<dynamic>> fetchAnyProducts(int count) async {
    var url = Uri.https(baseUrl, '$apiVersion/', {
      'page': '0',
      'limit': '$count',
    });
    final response = await client.get(url);

    if (response.statusCode == 200) {
      var jsonData = json.decode(utf8.decode(response.bodyBytes));
      return returnJsonDataAsList(jsonData);
    } else {
      throw Exception('Failed to fetch data');
    }
  }

  @override
  Future<Map<String, dynamic>> fetchProductsByCategory(
      categoryId, limit, page) async {
    var url = Uri.https(baseUrl, apiVersion, {
      'page': '$page',
      'limit': '$limit',
      'category': '$categoryId',
    });
    final response = await client.get(url);

    if (response.statusCode == 200) {
      var jsonData = json.decode(utf8.decode(response.bodyBytes));
      return jsonData;
    } else {
      throw Exception('Failed to fetch data');
    }
  }

  @override
  Future<List<dynamic>> fetchOnlyCategories() async {
    var url = Uri.https(baseUrl, '$apiVersion/categories');
    final response = await client.get(url);

    if (response.statusCode == 200) {
      var jsonData = json.decode(utf8.decode(response.bodyBytes));
      return returnJsonDataAsList(jsonData);
    } else {
      throw Exception('Failed to fetch data');
    }
  }

  @override
  Future<Map<String, dynamic>> fetchProductByID(int id) async {
    var url = Uri.https(
      baseUrl,
      '$apiVersion/$id',
    );
    final response = await client.get(url);
    if (response.statusCode == 200) {
      var jsonData = json.decode(utf8.decode(response.bodyBytes));
      return jsonData;
    } else {
      throw Exception('Failed to fetch data');
    }
  }

  List returnJsonDataAsList(jsonData) {
    try {
      return jsonData['data'] as List;
    } catch (e) {
      throw Exception(
          'Exception while converting data in the form of a list: $e');
    }
  }

  @override
  Future<String> postOrder(Map<String, int> orderData) async {
    Map<String, dynamic> requestBody = {
      'positions': orderData,
      'token': '',
    };

    var url = Uri.https(
      baseUrl,
      orderVersion,
    );
    debugPrint(jsonEncode(requestBody));
    final response = await client.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(requestBody),
    );

    if (response.statusCode == 201) {
      return 'complete';
    } else if (response.statusCode == 422) {
      throw Exception('Validation Error');
    } else {
      throw Exception(
          'Failed to post order. Status code: ${response.statusCode}');
    }
  }
}
