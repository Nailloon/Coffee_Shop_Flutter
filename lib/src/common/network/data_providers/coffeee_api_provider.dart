import 'dart:convert';
import 'package:coffee_shop/src/common/network/data_providers/interface_data_procider.dart';
import 'package:http/http.dart' as http;

final class CoffeShopApiDataProvider implements IDataProvider {
  final String baseUrl = 'coffeeshop.academy.effective.band';
  final String apiVersion = '/api/v1/products';
  final http.Client client = http.Client();

  @override
  Future<List<dynamic>> loadAnyProducts(int count) async {
    var url = Uri.https(baseUrl, '$apiVersion/', {
      'page': '0',
      'limit': '$count',
    });
    final response = await client.get(url);

    if (response.statusCode == 200) {
      var jsonData = json.decode(utf8.decode(response.bodyBytes));
      return returnJsonDataAsList(jsonData);
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  Future<Map<String, dynamic>> loadProductsByCategory(
      categoryId, limit, page) async {
    var url =
        Uri.https(baseUrl, apiVersion, {
      'page': '$page',
      'limit': '$limit',
      'category': '$categoryId',
    });
    final response = await client.get(url);

    if (response.statusCode == 200) {
      var jsonData = json.decode(utf8.decode(response.bodyBytes));
      return jsonData;
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  Future<List<dynamic>> loadOnlyCategories() async {
    var url = Uri.https(baseUrl, '$apiVersion/categories');
    final response = await client.get(url);

    if (response.statusCode == 200) {
      var jsonData = json.decode(utf8.decode(response.bodyBytes));
      return returnJsonDataAsList(jsonData);
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  Future<Map<String, dynamic>> loadProductByID(int id) async {
    var url = Uri.https(
      baseUrl,
      '$apiVersion/$id',
    );
    final response = await client.get(url);
    if (response.statusCode == 200) {
      var jsonData = json.decode(utf8.decode(response.bodyBytes));
      return jsonData;
    } else {
      throw Exception('Failed to load data');
    }
  }

  List returnJsonDataAsList(jsonData){
    return jsonData['data'] as List;
  }
}
