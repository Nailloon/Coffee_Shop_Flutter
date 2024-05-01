import 'dart:io';

import 'package:coffee_shop/src/common/network/data_sources/products_data_source/interface_products_data_source.dart';
import 'package:coffee_shop/src/common/network/repositories/products_repository/interface_products_repository.dart';
import 'package:coffee_shop/src/features/database/data_source/savable_products_data_source.dart';
import 'package:coffee_shop/src/features/menu/models/category_model.dart';
import 'package:coffee_shop/src/features/menu/data/product_dto.dart';
import 'package:coffee_shop/src/features/menu/models/product_model.dart';
import 'package:coffee_shop/src/features/menu/utils/product_mapper.dart';

class ProductRepository implements IProductRepository {
  final IProductsDataSource networkProductsDataSource;
  final ISavableProductsDataSource savableProductsDataSource;
  const ProductRepository(
      this.networkProductsDataSource, this.savableProductsDataSource,
      {this.limitForPage = 25});
  final int limitForPage;

  @override
  Future<bool> loadMoreProductsByCategory(
      CategoryModel category, int page) async {
    List<ProductModel> products =
        await _loadProductsByCategoryFromAnyRepository(
            category, limitForPage, page);
    if (products.length < limitForPage) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Future<ProductModel> loadProductByID({required int id}) async {
    try {
      ProductDTO dto = await networkProductsDataSource.fetchProductByID(id);
      return dto.toModel();
    } on Exception catch (e) {
      if (e is SocketException) {
        ProductDTO dto = await savableProductsDataSource.fetchProductByID(id);
        return dto.toModel();
      }
      rethrow;
    }
  }

  @override
  Future<void> initialLoadProductsByCategory(CategoryModel categoryData,
      {int page = 0}) async {
    await _loadProductsByCategoryFromAnyRepository(
        categoryData, limitForPage, page);
  }

  @override
  Future<List<ProductModel>> loadAnyProducts(int limitForProducts) async {
    List<ProductModel> products = [];
    try {
      List<ProductDTO> dtoProducts =
          await networkProductsDataSource.fetchAnyProducts(limitForProducts);

      for (var element in dtoProducts) {
        products.add(element.toModel());
      }
      return products;
    } on Exception catch (e) {
      if (e is SocketException) {
        List<ProductDTO> dtoProducts =
            await savableProductsDataSource.fetchAnyProducts(limitForProducts);
        for (var element in dtoProducts) {
          products.add(element.toModel());
        }
        return products;
      }
      rethrow;
    }
  }

  Future<List<ProductModel>> _loadProductsByCategoryFromAnyRepository(
      CategoryModel category, int limit, int page) async {
    List<ProductModel> products = [];
    try {
      List<ProductDTO> dtoProducts = await networkProductsDataSource
          .fetchProductsByCategory(category.id, limitForPage, page);
      for (var element in dtoProducts) {
        products.add(element.toModel());
      }
      savableProductsDataSource.saveProducts(dtoProducts, category.id);
    } on Exception catch (e) {
      if (e is SocketException) {
        final int offset = limitForPage * page;
        List<ProductDTO> dtoProducts = await savableProductsDataSource
            .fetchProductsByCategory(category.id, limitForPage, offset);
        for (var element in dtoProducts) {
          products.add(element.toModel());
        }
      }
    }
    category.addListOfProductsIntoCategory(products);
    return products;
  }
}
