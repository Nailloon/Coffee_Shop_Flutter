import 'dart:io';

import 'package:coffee_shop/src/common/network/data_sources/products_data_source/interface_products_data_source.dart';
import 'package:coffee_shop/src/common/network/repositories/products_repository/interface_products_repository.dart';
import 'package:coffee_shop/src/features/database/data_source/savable_products_data_source.dart';
import 'package:coffee_shop/src/features/menu/data/category_data.dart';
import 'package:coffee_shop/src/features/menu/data/product_data.dart';

class ProductRepository implements IProductRepository {
  final IProductsDataSource networkProductsDataSource;
  final ISavableProductsDataSource savableProductsDataSource;
  const ProductRepository(
      this.networkProductsDataSource, this.savableProductsDataSource,
      {this.limitForPage = 25});
  final int limitForPage;

  @override
  Future<bool> loadMoreProductsByCategory(
      CategoryData category, int page) async {
    List<ProductData> products = await _loadProductsByCategoryFromAnyRepository(
        category, limitForPage, page);
    if (products.length < limitForPage) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Future<ProductData> loadProductByID({required int id}) async {
    try {
      return networkProductsDataSource.fetchProductByID(id);
    } on Exception catch (e) {
      if (e is SocketException) {
        return savableProductsDataSource.fetchProductByID(id);
      }
      rethrow;
    }
  }

  @override
  Future<void> initialLoadProductsByCategory(CategoryData categoryData,
      {int page = 0}) async {
    await _loadProductsByCategoryFromAnyRepository(
        categoryData, limitForPage, page);
  }

  @override
  Future<List<ProductData>> loadAnyProducts(int limitForProducts) async {
    try {
      return await networkProductsDataSource.fetchAnyProducts(limitForProducts);
    } on Exception catch (e) {
      if (e is SocketException) {
        return await savableProductsDataSource
            .fetchAnyProducts(limitForProducts);
      }
      rethrow;
    }
  }

  Future<List<ProductData>> _loadProductsByCategoryFromAnyRepository(
      CategoryData category, int limit, int page) async {
    List<ProductData> products = [];
    try {
      products = await networkProductsDataSource.fetchProductsByCategory(
          category.id, limitForPage, page);
      savableProductsDataSource.saveProducts(products, category.id);
    } on Exception catch (e) {
      if (e is SocketException) {
        final int offset = limitForPage * page;
        products = await savableProductsDataSource.fetchProductsByCategory(
            category.id, limitForPage, offset);
      }
    }
    category.addListOfProductsIntoCategory(products);
    return products;
  }
}
