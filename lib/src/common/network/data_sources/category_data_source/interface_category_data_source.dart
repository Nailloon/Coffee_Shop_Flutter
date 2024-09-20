import 'package:coffee_shop/src/features/menu/data/category_dto.dart';

abstract interface class ICategoryDataSource {
  Future<List<CategoryDTO>> fetchOnlyCategories();
}
