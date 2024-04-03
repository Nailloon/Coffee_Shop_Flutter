import 'package:coffee_shop/src/features/menu/data/category_data.dart';

abstract interface class IRepository {
  Future<List<CategoryData>> loadCategoriesWithProducts(
      {int limitForCategory, int page});
  Future<bool> sendOrder({required Map<String, int> products});
  Future<bool> loadMoreProductsByCategory(CategoryData category, int page);
}
