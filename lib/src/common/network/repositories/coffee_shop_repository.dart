import 'package:coffee_shop/src/common/network/data_providers/coffeee_api_provider.dart';
import 'package:coffee_shop/src/common/network/repositories/interface_repository.dart';
import 'package:coffee_shop/src/features/menu/data/category_data.dart';
import 'package:coffee_shop/src/features/menu/data/product_data.dart';
import 'package:flutter/material.dart';

class CoffeeShopRepository implements IRepository {
  final api = CoffeShopApiDataProvider();
  static const int limitForPage = 25;

  @override
  Future<CategoryData> loadProductsByCategory(categoryData,
      {int id = 1, int limit = 10, int page = 0}) async {
    final Map<String, dynamic> jsonResponse =
        await api.fetchProductsByCategory(id, limit, page);
    return CategoryData.fromJson(categoryData, jsonResponse);
  }

  @override
  Future<List<CategoryData>> loadCategoriesWithProducts(
      {int limitForCategory = 8, int page = 0}) async {
    List<dynamic> categoriesData = await api.fetchOnlyCategories();
    List<CategoryData> categories = [];
    for (var categoryData in categoriesData) {
      var id = categoryData['id'];
      CategoryData category = await loadProductsByCategory(categoryData,
          id: id, limit: limitForCategory, page: page);
      categories.add(category);
    }

    return categories;
  }

  @override
  Future<List<CategoryData>> loadAnyProducts(int limitForProducts) async {
    var data = await api.fetchAnyProducts(limitForProducts);
    List<CategoryData> categories = [];

    for (var productJson in data) {
      var category = CategoryData.fromJsonWithProduct(
          productJson['category'], productJson);
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
  }

  @override
  Future<List<CategoryData>> loadOnlyCategories() async {
    List<dynamic> categoriesData = await api.fetchOnlyCategories();
    List<CategoryData> categories = [];

    for (var categoryData in categoriesData) {
      CategoryData category = CategoryData(
          id: categoryData['id'], name: categoryData['slug'], products: []);
      categories.add(category);
    }

    return categories;
  }

  @override
  Future<ProductData> loadProductByID({int id = 0}) async {
    final Map<String, dynamic> jsonResponse = await api.fetchProductByID(id);

    return ProductData.fromJson(jsonResponse);
  }

  @override
  Future<bool> sendOrder({required Map<String, int> products}) async {
    return await api.postOrder(products);
  }

  @override
  Future<bool> loadMoreProductsByCategory(
      CategoryData category, int page) async {
    final Map<String, dynamic> jsonResponse =
        await api.fetchProductsByCategory(category.id, limitForPage, page);
    int count = 0;
    for (var productJson in jsonResponse['data'] as List) {
      category.addProductIntoCategory(ProductData.fromJson(productJson));
      count+=1;
    }
    final length = jsonResponse.length;
    if (count < limitForPage) {
      debugPrint('$count');
      return true;
    } else {
      return false;
    }
  }
}
