import 'dart:convert';

import 'package:coffee_shop/src/features/database/coffee_database.dart';
import 'package:coffee_shop/src/features/database/interface_savable_data_source.dart';
import 'package:coffee_shop/src/features/menu/data/category_data.dart';
import 'package:coffee_shop/src/features/menu/data/product_data.dart';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
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
  Future<void> saveCategoriesWithProducts(List<CategoryData> categories) async{
    for (var category in categories) {
      await saveCategory(category);
      await saveProducts(category.products, category.id);
    }
  }

  @override
  Future<void> saveCategory(CategoryData category) async{
    try {
      await database.into(database.categories).insertOnConflictUpdate(
          CategoriesCompanion(
              id: Value(category.id), name: Value(category.name)));
    } on Exception catch (e) {
      if (changeCategory(category) != true) {
        rethrow;
      }
    }
  }

  Future<void> saveProducts(List<ProductData> products, int categoryId) async {
    for (var product in products) {
      await saveProduct(product, categoryId);
    }
  }

  @override
  Future<void> saveProduct(ProductData product, int categoryId) async {
  var existingProduct = await (database.select(database.products)
      ..where((tbl) => tbl.id.equals(product.id))).getSingleOrNull();

  if (existingProduct == null) {
  await database.into(database.products).insertOnConflictUpdate(
      ProductsCompanion(
        id: Value(product.id),
        name: Value(product.name),
        description: Value(product.description),
        imageUrl: Value(product.imageUrl),
        categoryId: Value(categoryId),
        prices: Value(json.encode(product.prices)),
      ),
    );
  } else {
    await database.update(database.products).replace(
      ProductsCompanion(
        id: Value(product.id),
        name: Value(product.name),
        description: Value(product.description),
        imageUrl: Value(product.imageUrl),
        categoryId: Value(categoryId),
        prices: Value(json.encode(product.prices)),
      ),
    );
  }
}

  Future<List<ProductData>> fetchAnyProducts() async {
    var productsFromDB = await (database.select(database.products)..limit(300)).get();
    List<ProductData> products = [];
    for (var product in productsFromDB) {
      var jsonProduct = product.toJson();
      products.add(ProductData.fromJson(jsonProduct));
    }
    debugPrint('ProductsLength: ${productsFromDB.length}');
    return products;
  }
}
