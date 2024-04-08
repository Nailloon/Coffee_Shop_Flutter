import 'package:coffee_shop/src/features/menu/data/category_data.dart';

abstract interface class ICategoryRepository {
  Future<List<CategoryData>> loadOnlyCategories();
}
