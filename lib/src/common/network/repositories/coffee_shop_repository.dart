import 'package:coffee_shop/src/common/network/repositories/category_repository/category_repository.dart';
import 'package:coffee_shop/src/common/network/repositories/category_repository/interface_category_repository.dart';
import 'package:coffee_shop/src/common/network/repositories/order_repository/interface_order_repository.dart';
import 'package:coffee_shop/src/common/network/repositories/products_repository/interface_products_repository.dart';
import 'package:coffee_shop/src/common/network/repositories/interface_repository.dart';
import 'package:coffee_shop/src/common/network/repositories/order_repository/order_repository.dart';
import 'package:coffee_shop/src/common/network/repositories/products_repository/products_repository.dart';
import 'package:coffee_shop/src/features/database/database_data_source.dart';
import 'package:coffee_shop/src/features/menu/data/category_data.dart';

class CoffeeShopRepository implements IRepository {
  final ICategoryRepository categoryRepository = CategoryRepository();
  final IProductRepository productRepository = ProductRepository();
  final IOrderRepository orderRepository = OrderRepository();
  final db = DataBaseSource();
  static const int limitForPage = 25;

  @override
  Future<List<CategoryData>> loadCategoriesWithProducts(
      {int limitForCategory = limitForPage, int page = 0}) async {
    List<CategoryData> categoriesData =
        await categoryRepository.loadOnlyCategories();
    for (var categoryData in categoriesData) {
      var id = categoryData.id;
      await productRepository.loadProductsByCategory(categoryData,
          id: id, limit: limitForCategory, page: page);
    }
    db.saveCategoriesWithProducts(categoriesData);

    return categoriesData;
  }

  @override
  Future<bool> sendOrder({required Map<String, int> products}) async {
    await db.fetchAnyProducts();
    return await orderRepository.sendOrder(products: products);
  }

  @override
  Future<bool> loadMoreProductsByCategory(
      CategoryData category, int page) async {
      await db.saveCategoriesWithProducts([category]);
    return await productRepository.loadMoreProductsByCategory(category, page);
  }
}
