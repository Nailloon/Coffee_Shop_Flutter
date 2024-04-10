import 'package:coffee_shop/src/features/database/data_source/interface_savable_data_source.dart';
import 'package:coffee_shop/src/features/database/data_source/database_data_source.dart';
import 'package:coffee_shop/src/features/database/savable_category_repository/interface_savable_category_repository.dart';
import 'package:coffee_shop/src/features/menu/data/category_data.dart';

class SavableCategoryRepository implements ISavableCategoryRepository {
  ISavableDataSource database = DataBaseSource();
  @override
  Future<List<CategoryData>> loadCategories() async {
    List<CategoryData> categories = await database.fetchOnlyCategories();
    return categories;
  }

  @override
  void saveCategories(List<CategoryData> categories) {
    database.saveCategoriesWithProducts(categories);
  }
}
