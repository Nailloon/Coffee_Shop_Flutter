import 'dart:convert';

import 'package:coffee_shop/src/common/network/data_sources/products_data_source/interface_products_data_source.dart';
import 'package:coffee_shop/src/features/database/database/coffee_database.dart';
import 'package:coffee_shop/src/features/menu/data/product_data.dart';
import 'package:drift/drift.dart';
import 'package:flutter/material.dart';

abstract interface class ISavableProductsDataSource
    implements IProductsDataSource {
  void saveProducts(List<ProductData> products, int categoryId);
  void saveProduct(ProductData product, int categoryId);
}

class SavableProductsDataSource implements ISavableProductsDataSource {
  final AppDatabase database;
  const SavableProductsDataSource(this.database);

  @override
  Future<List<ProductData>> fetchAnyProducts(int count) async {
    var productsFromDB =
        await (database.select(database.products)..limit(count)).get();
    List<ProductData> products = [];
    for (var product in productsFromDB) {
      var jsonProduct = product.toJson();
      products.add(ProductData.fromJson(jsonProduct));
    }
    debugPrint('ProductsLength: ${productsFromDB.length}');
    return products;
  }

  @override
  Future<ProductData> fetchProductByID(int id) async {
    List<Product> product = await (database.select(database.products)
          ..where((product) => product.id.equals(id)))
        .get();
    return ProductData.fromJson(product[0].toJson());
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
      var jsonProduct = product.toJson();
      products.add(ProductData.fromJson(jsonProduct));
    }
    debugPrint('Products: $products');
    return products;
  }

  @override
  void saveProduct(ProductData product, int categoryId) {
    database.into(database.products).insertOnConflictUpdate(
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

  @override
  void saveProducts(List<ProductData> products, int categoryId) {
    for (var product in products) {
      saveProduct(product, categoryId);
    }
  }
}
