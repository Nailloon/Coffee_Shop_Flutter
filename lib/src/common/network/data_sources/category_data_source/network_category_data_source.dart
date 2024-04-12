import 'dart:convert';
import 'package:coffee_shop/src/common/functions/convert_functions.dart';
import 'package:coffee_shop/src/common/functions/exception_functions.dart';
import 'package:coffee_shop/src/common/network/data_sources/category_data_source/interface_category_data_source.dart';
import 'package:coffee_shop/src/features/menu/data/category_data.dart';
import 'package:http/http.dart' as http;

class NetworkCategoryDataSource implements ICategoryDataSource {
  final String baseUrl = 'coffeeshop.academy.effective.band';
  final String apiVersion = '/api/v1/products';
  final Duration durationForBigRequest = const Duration(milliseconds: 800);
  final Duration durationForSmallRequest = const Duration(milliseconds: 500);
  final http.Client client;
  NetworkCategoryDataSource(this.client);

  @override
  Future<List<CategoryData>> fetchOnlyCategories() async {
    try {
      var url = Uri.https(baseUrl, '$apiVersion/categories');
      final response = await client.get(url).timeout(durationForBigRequest);

      if (response.statusCode == 200) {
        var jsonData = json.decode(utf8.decode(response.bodyBytes));
        List<dynamic> categoriesData = returnJsonDataAsList(jsonData);
        List<CategoryData> categories = [];

        for (var categoryData in categoriesData) {
          CategoryData category = CategoryData(
              id: categoryData['id'], name: categoryData['slug'], products: []);
          categories.add(category);
        }

        return categories;
      } else {
        throw Exception('Failed to fetch data');
      }
    } on Exception catch (e) {
      noInternet(e);
      rethrow;
    }
  }
}
