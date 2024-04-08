import 'dart:convert';

import 'package:coffee_shop/src/features/database/coffee_database.dart';
import 'package:coffee_shop/src/features/database/interface_savable_data_source.dart';
import 'package:coffee_shop/src/features/menu/data/category_data.dart';
import 'package:coffee_shop/src/features/menu/data/product_data.dart';
import 'package:drift/drift.dart';
import 'package:flutter/material.dart';

final class DataBaseSource implements ISavableDataSource {
  final database = AppDatabase();
  @override
  bool changeCategory(CategoryData category) {
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
    for (var category in allItems) {
      categories.add(
          CategoryData(id: category.id, name: category.name, products: []));
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
  Future<List<ProductData>> fetchProductsByCategory(
      int categoryId, int limit, int offset) async {
    List<Product> productsFromDatabase =
        await (database.select(database.products)
              ..where((product) => product.categoryId.equals(categoryId))
              ..limit(limit, offset: offset))
            .get();
    List<ProductData> products = [];
    for (var product in productsFromDatabase) {
      products.add(ProductData(
          id: product.id,
          name: product.name,
          description: product.description ?? '',
          imageUrl: product.imageUrl ?? '',
          prices: jsonDecode(product.prices)));
    }
    debugPrint('Products: $products');
    return products;
  }

  @override
  void saveCategoriesWithProducts(List<CategoryData> categories) {
    for (var category in categories) {
      saveCategory(category);
      saveProducts(category.products, category.id);
    }
  }

  @override
  void saveCategory(CategoryData category) {
    database.into(database.categories).insert(CategoriesCompanion(
        id: Value(category.id), name: Value(category.name)));
  }

  void saveProducts(List<ProductData> products, int categoryId) {
    for (var product in products) {
      saveProduct(product, categoryId);
    }
  }

  @override
  void saveProduct(ProductData product, int categoryId) {
    database.into(database.products).insert(ProductsCompanion.insert(
        id: Value(product.id),
        name: product.name,
        categoryId: categoryId,
        prices: product.prices.toString()));
  }
}
