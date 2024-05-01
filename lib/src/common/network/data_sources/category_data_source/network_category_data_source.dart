import 'dart:convert';
import 'package:coffee_shop/src/common/functions/convert_functions.dart';
import 'package:coffee_shop/src/common/functions/exception_functions.dart';
import 'package:coffee_shop/src/common/network/data_sources/category_data_source/interface_category_data_source.dart';
import 'package:coffee_shop/src/features/menu/data/category_dto.dart';
import 'package:http/http.dart' as http;

class NetworkCategoryDataSource implements ICategoryDataSource {
  final String baseUrl = 'coffeeshop.academy.effective.band';
  final String apiVersion = '/api/v1/products';
  final http.Client client;
  NetworkCategoryDataSource(this.client);

  @override
  Future<List<CategoryDTO>> fetchOnlyCategories() async {
    try {
      var url = Uri.https(baseUrl, '$apiVersion/categories');
      final response = await client.get(url);
      if (response.statusCode == 200) {
        var jsonData = json.decode(utf8.decode(response.bodyBytes));
        List<dynamic> categoriesData = returnJsonDataAsList(jsonData);
        List<CategoryDTO> categories = [];

        for (var jsonCategory in categoriesData) {
          CategoryDTO category =
              CategoryDTO.fromJsonWithoutProducts(jsonCategory);
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
