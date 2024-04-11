import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:coffee_shop/src/common/network/data_sources/interface_data_source.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

final class CoffeShopApiDataSource implements IDataSource {
  final String baseUrl = 'coffeeshop.academy.effective.band';
  final String apiVersion = '/api/v1/products';
  final String orderVersion = 'api/v1/orders';
  final http.Client client = http.Client();
  final Duration durationForBigRequest = const Duration(seconds: 3);
  final Duration durationForSmallRequest = const Duration(seconds: 2);
  final SocketException socketException =
      const SocketException('Failed to connect to api');

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
      int categoryId, int limit, int page) async {
    try {
      var url = Uri.https(baseUrl, apiVersion, {
        'page': '$page',
        'limit': '$limit',
        'category': '$categoryId',
      });
      final response = await client.get(url).timeout(durationForSmallRequest);

      if (response.statusCode == 200) {
        var jsonData = json.decode(utf8.decode(response.bodyBytes));
        return jsonData;
      } else {
        throw Exception('Failed to fetch data');
      }
    } on Exception catch (e) {
      noInternet(e);
      rethrow;
    }
  }

  @override
  Future<List<dynamic>> fetchOnlyCategories() async {
    try {
      var url = Uri.https(baseUrl, '$apiVersion/categories');
      final response = await client.get(url).timeout(durationForBigRequest);

      if (response.statusCode == 200) {
        var jsonData = json.decode(utf8.decode(response.bodyBytes));
        return returnJsonDataAsList(jsonData);
      } else {
        throw Exception('Failed to fetch data');
      }
    } on Exception catch (e) {
      noInternet(e);
      rethrow;
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

  @override
  Future<bool> postOrder(Map<String, int> orderData) async {
    debugPrint(orderData.toString());
    try {
      Map<String, dynamic> requestBody = {
        'positions': orderData,
        'token': '',
      };

      var url = Uri.https(
        baseUrl,
        orderVersion,
      );
      final response = await client
          .post(
            url,
            headers: {'Content-Type': 'application/json'},
            body: jsonEncode(requestBody),
          )
          .timeout(durationForSmallRequest);

      if (response.statusCode == 201) {
        return true;
      } else if (response.statusCode == 422) {
        throw Exception('Validation Error');
      } else {
        return false;
      }
    } on Exception catch (e) {
      noInternet(e);
      rethrow;
    }
  }

  void noInternet(Exception e) {
    if (e is TimeoutException || e is SocketException) {
      throw socketException;
    }
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
