import 'package:coffee_shop/src/features/menu/data/category_data.dart';
import 'package:coffee_shop/src/features/menu/data/product_data.dart';

abstract interface class ISavableDataSource {
  Future<List<CategoryData>> fetchOnlyCategories();
  Future<Map<String, dynamic>> fetchProductsByCategory(
      int categoryId, int limit, int page);
  Future<ProductData> fetchProductByID(int id);
  void saveCategory(CategoryData category);
  void saveProduct(ProductData product);
  void saveCategoriesWithProducts(List<CategoryData> categories);
  bool changeProduct(ProductData product);
  bool changeCategoty(CategoryData category);
}
