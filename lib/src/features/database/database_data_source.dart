import 'package:coffee_shop/src/features/database/coffee_database.dart';
import 'package:coffee_shop/src/features/database/interface_savable_data_source.dart';
import 'package:coffee_shop/src/features/menu/data/category_data.dart';
import 'package:coffee_shop/src/features/menu/data/product_data.dart';
import 'package:flutter/material.dart';

final class DataBaseSource implements ISavableDataSource {
  final database = AppDatabase();
  @override
  bool changeCategoty(CategoryData category) {
    // TODO: implement changeCategoty
    throw UnimplementedError();
  }

  @override
  bool changeProduct(ProductData product) {
    // TODO: implement changeProduct
    throw UnimplementedError();
  }

  @override
  Future<List<CategoryData>> fetchOnlyCategories() async {
    List<Category> allItems = await database.select(database.categories).get();
    List<CategoryData> categories = [];
    debugPrint('items in database: $allItems');
    for (var category in allItems){
      categories.add(CategoryData(id: category.id, name: category.name, products: []));
    }
    debugPrint('Categories: $categories');
    return categories;
  }

  @override
  Future<ProductData> fetchProductByID(int id) {
    // TODO: implement fetchProductByID
    throw UnimplementedError();
  }

  @override
  Future<Map<String, dynamic>> fetchProductsByCategory(
      int categoryId, int limit, int page) {
    // TODO: implement fetchProductsByCategory
    throw UnimplementedError();
  }

  @override
  void saveCategoriesWithProducts(List<CategoryData> categories) {
    // TODO: implement saveCategoriesWithProducts
  }

  @override
  void saveCategory(CategoryData category) {
    // TODO: implement saveCategory
  }

  @override
  void saveProduct(ProductData product) {
    // TODO: implement saveProduct
  }
}
