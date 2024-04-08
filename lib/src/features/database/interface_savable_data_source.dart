import 'package:coffee_shop/src/features/menu/data/category_data.dart';
import 'package:coffee_shop/src/features/menu/data/product_data.dart';

abstract interface class ISavableDataSource {
  Future<List<CategoryData>> fetchOnlyCategories();
  Future<List<ProductData>> fetchProductsByCategory(
      int categoryId, int limit, int offset);
  Future<ProductData> fetchProductByID(int id);
  void saveCategory(CategoryData category);
  void saveProduct(ProductData product, int categoryId);
  void saveCategoriesWithProducts(List<CategoryData> categories);
  void changeProduct(ProductData product);
  void changeCategory(CategoryData category);
}
