import 'package:coffee_shop/src/features/menu/data/category_data.dart';
import 'package:coffee_shop/src/features/menu/data/product_data.dart';

abstract interface class ISavableRepository {
  Future<List<CategoryData>> initialLoadCategoriesWithProducts(
      int limitForCategory);
  void saveCategories(List<CategoryData> categories);
  void saveProducts(List<ProductData> products, int categoryId);
  Future<bool> loadMoreProductsByCategory(CategoryData category, int page,
      {int limitForCategory});
}
