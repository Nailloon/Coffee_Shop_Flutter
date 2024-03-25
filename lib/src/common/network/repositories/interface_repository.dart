import 'package:coffee_shop/src/features/menu/data/category_data.dart';
import 'package:coffee_shop/src/features/menu/data/product_data.dart';

abstract interface class IRepository {
  Future<List<CategoryData>> fetchAnyProducts(int limitForProducts);
  Future<CategoryData> fetchProductsByCategory(categoryData, {int id, int limit, int page});
  Future<List<CategoryData>> fetchCategoriesWithProducts({int limitForCategory, int page});
  Future<List<CategoryData>> fetchOnlyCategories();
  Future<ProductData> fetchProductByID({int id});
  Future<String> sendOrder({required Map<String, int> products});
}