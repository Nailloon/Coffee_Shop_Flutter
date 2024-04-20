import 'package:coffee_shop/src/features/menu/models/category_model.dart';

abstract interface class ICategoryRepository {
  Future<List<CategoryModel>> loadOnlyCategories();
}
