import 'package:coffee_shop/src/features/menu/data/category_data.dart';
import 'package:coffee_shop/src/features/menu/data/product_data.dart';

abstract interface class ISavableRepository{
  Future<List<CategoryData>> loadCategoriesWithProducts(int limitForCategory, int page);
  void saveCategories(List<CategoryData> categories);
  void saveProducts(List<ProductData> products);
}