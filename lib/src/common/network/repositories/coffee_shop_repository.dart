import 'package:coffee_shop/src/common/network/repositories/category_repository.dart';
import 'package:coffee_shop/src/common/network/repositories/interface_category_repository.dart';
import 'package:coffee_shop/src/common/network/repositories/interface_order_repository.dart';
import 'package:coffee_shop/src/common/network/repositories/interface_products_repository.dart';
import 'package:coffee_shop/src/common/network/repositories/interface_repository.dart';
import 'package:coffee_shop/src/common/network/repositories/order_repository.dart';
import 'package:coffee_shop/src/common/network/repositories/product_repository.dart';
import 'package:coffee_shop/src/features/menu/data/category_data.dart';

class CoffeeShopRepository implements IRepository {
  final ICategoryRepository categoryRepository = CategoryRepository();
  final IProductRepository productRepository = ProductRepository();
  final IOrderRepository orderRepository = OrderRepository();
  static const int limitForPage = 25;

  @override
  Future<List<CategoryData>> loadCategoriesWithProducts(
      {int limitForCategory = limitForPage, int page = 0}) async {
    List<CategoryData> categoriesData = await categoryRepository.loadOnlyCategories();
    for (var categoryData in categoriesData) {
      var id = categoryData.id;
      await productRepository.loadProductsByCategory(categoryData,
          id: id, limit: limitForCategory, page: page);
    }

    return categoriesData;
  }

  @override
  Future<bool> sendOrder({required Map<String, int> products}) async {
    return await orderRepository.sendOrder(products: products);
  }
  
  @override
  Future<bool> loadMoreProductsByCategory(CategoryData category, int page) async {
    return await productRepository.loadMoreProductsByCategory(category, page);
  }
  
}
