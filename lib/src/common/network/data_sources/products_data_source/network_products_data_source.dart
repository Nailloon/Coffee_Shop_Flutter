import 'dart:convert';

import 'package:coffee_shop/src/common/functions/convert_functions.dart';
import 'package:coffee_shop/src/common/functions/exception_functions.dart';
import 'package:coffee_shop/src/common/network/data_sources/products_data_source/interface_products_data_source.dart';
import 'package:coffee_shop/src/features/menu/data/product_dto.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class NetworkProductsDataSource implements IProductsDataSource {
  final String baseUrl = 'coffeeshop.academy.effective.band';
  final String apiVersion = '/api/v1/products';
  final Duration durationForBigRequest = const Duration(milliseconds: 800);
  final Duration durationForSmallRequest = const Duration(milliseconds: 500);
  final http.Client client;
  NetworkProductsDataSource(this.client);
  @override
  Future<List<ProductDTO>> fetchAnyProducts(int count) async {
    try {
      var url = Uri.https(baseUrl, '$apiVersion/', {
        'page': '0',
        'limit': '$count',
      });
      final response = await client.get(url).timeout(durationForBigRequest);

      if (response.statusCode == 200) {
        var jsonData = json.decode(utf8.decode(response.bodyBytes));
        final List<ProductDTO> products = [];
        List<dynamic> jsonList = returnJsonDataAsList(jsonData);
        for (var json in jsonList) {
          products.add(ProductDTO.fromJson(json));
        }
        return products;
      } else {
        throw Exception('Failed to fetch data');
      }
    } on Exception catch (e) {
      noInternet(e);
      rethrow;
    }
  }

  @override
  Future<ProductDTO> fetchProductByID(int id) async {
    try {
      var url = Uri.https(
        baseUrl,
        '$apiVersion/$id',
      );
      final response = await client.get(url).timeout(durationForSmallRequest);
      if (response.statusCode == 200) {
        var jsonData = json.decode(utf8.decode(response.bodyBytes));
        return ProductDTO.fromJson(jsonData);
      } else {
        throw Exception('Failed to fetch data');
      }
    } on Exception catch (e) {
      noInternet(e);
      rethrow;
    }
  }

  @override
  Future<List<ProductDTO>> fetchProductsByCategory(
      int categoryId, int limit, int page) async {
    try {
      var url = Uri.https(baseUrl, apiVersion, {
        'page': '$page',
        'limit': '$limit',
        'category': '$categoryId',
      });
      final response = await client.get(url).timeout(durationForBigRequest);

      if (response.statusCode == 200) {
        var jsonData = json.decode(utf8.decode(response.bodyBytes));
        final List<ProductDTO> products = [];
        List<dynamic> jsonList = returnJsonDataAsList(jsonData);
        debugPrint(products.toString());
        for (var json in jsonList) {
          products.add(ProductDTO.fromJson(json));
        }
        return products;
      } else {
        throw Exception('Failed to fetch data');
      }
    } on Exception catch (e) {
      noInternet(e);
      rethrow;
    }
  }
}
