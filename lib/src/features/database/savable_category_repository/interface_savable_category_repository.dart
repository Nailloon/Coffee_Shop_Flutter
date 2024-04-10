import 'package:coffee_shop/src/features/menu/data/category_data.dart';

abstract interface class ISavableCategoryRepository {
  Future<List<CategoryData>> loadCategories();
  void saveCategories(List<CategoryData> categories);
}
