import 'dart:io';

import 'package:coffee_shop/src/common/network/repositories/category_repository/category_repository.dart';
import 'package:coffee_shop/src/common/network/repositories/category_repository/interface_category_repository.dart';
import 'package:coffee_shop/src/common/network/repositories/order_repository/interface_order_repository.dart';
import 'package:coffee_shop/src/common/network/repositories/products_repository/interface_products_repository.dart';
import 'package:coffee_shop/src/common/network/repositories/interface_repository.dart';
import 'package:coffee_shop/src/common/network/repositories/order_repository/order_repository.dart';
import 'package:coffee_shop/src/common/network/repositories/products_repository/products_repository.dart';
import 'package:coffee_shop/src/features/database/database_repository.dart';
import 'package:coffee_shop/src/features/menu/data/category_data.dart';

class CoffeeShopRepository implements IRepository {
  final ICategoryRepository categoryRepository = CategoryRepository();
  final IProductRepository productRepository = ProductRepository();
  final IOrderRepository orderRepository = OrderRepository();
  final db = DatabaseRepository();
  static const int limitForPage = 25;

  @override
  Future<List<CategoryData>> loadCategoriesWithProducts(
      {int limitForCategory = limitForPage, int page = 0}) async {
    List<CategoryData> categoriesData = [];
    try {
      categoriesData = await categoryRepository.loadOnlyCategories();
      for (var categoryData in categoriesData) {
        var id = categoryData.id;
        await productRepository.loadProductsByCategory(categoryData,
            id: id, limit: limitForCategory, page: page);
      }
      db.saveCategories(categoriesData);
    } on Exception catch (e) {
      if (e is SocketException) {
        return await db.initialLoadCategoriesWithProducts(limitForPage);
      } else {
        rethrow;
      }
    }

    return categoriesData;
  }

  @override
  Future<bool> sendOrder({required Map<String, int> products}) async {
    return await orderRepository.sendOrder(products: products);
  }

  @override
  Future<bool> loadMoreProductsByCategory(
      CategoryData category, int page) async {
    try {
      final bool finished =
          await productRepository.loadMoreProductsByCategory(category, page);
      db.saveCategories([category]);
      return finished;
    } on Exception catch (e) {
      if (e is SocketException) {
        return await db.loadMoreProductsByCategory(category, page);
      } else {
        rethrow;
      }
    }
  }
}
