import 'package:coffee_shop/src/features/database/database/database_data_source.dart';
import 'package:coffee_shop/src/features/database/data_source/interface_savable_data_source.dart';
import 'package:coffee_shop/src/features/database/interface_savable_repository.dart';
import 'package:coffee_shop/src/features/menu/data/category_data.dart';
import 'package:coffee_shop/src/features/menu/data/product_data.dart';

class DatabaseRepository implements ISavableRepository {
  ISavableDataSource database = DataBaseSource();
  final int limitPerPage = 25;
  final int initialOffset = 0;
  @override
  Future<List<CategoryData>> initialLoadCategoriesWithProducts(
      int limitForCategory) async {
    List<CategoryData> categories = await database.fetchOnlyCategories();
    for (var category in categories) {
      List<ProductData> products = await database.fetchProductsByCategory(
          category.id, limitForCategory, initialOffset);
      for (var product in products) {
        category.addProductIntoCategory(product);
      }
    }
    return categories;
  }

  @override
  void saveCategories(List<CategoryData> categories) {
    database.saveCategoriesWithProducts(categories);
  }

  @override
  void saveProducts(List<ProductData> products, int categoryId) {
    database.saveProducts(products, categoryId);
  }

  @override
  Future<bool> loadMoreProductsByCategory(
      CategoryData category, int page) async {
    int count = 0;
    final int offset = page * limitPerPage;
    List<ProductData> products = await database.fetchProductsByCategory(
        category.id, limitPerPage, offset);
    for (var product in products) {
      category.addProductIntoCategory(product);
      count += 1;
    }
    if (count < limitPerPage) {
      return true;
    } else {
      return false;
    }
  }
}
