import 'package:coffee_shop/src/features/menu/data/category_data.dart';
import 'package:coffee_shop/src/features/menu/data/product_data.dart';

abstract interface class IRepository {
  Future<List<CategoryData>> loadAnyProducts(int limitForProducts);
  Future<CategoryData> loadProductsByCategory(categoryData,
      {int id, int limit, int page});
  Future<List<CategoryData>> loadCategoriesWithProducts(
      {int limitForCategory, int page});
  Future<List<CategoryData>> loadOnlyCategories();
  Future<ProductData> loadProductByID({int id});
  Future<bool> sendOrder({required Map<String, int> products});
  Future<bool> loadMoreProductsByCategory(CategoryData category, int page);
}
