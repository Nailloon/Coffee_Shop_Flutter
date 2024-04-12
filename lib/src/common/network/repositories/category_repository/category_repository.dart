import 'dart:io';

import 'package:coffee_shop/src/common/network/data_sources/category_data_source/interface_category_data_source.dart';
import 'package:coffee_shop/src/common/network/repositories/category_repository/interface_category_repository.dart';
import 'package:coffee_shop/src/features/database/data_source/savable_category_data_source.dart';
import 'package:coffee_shop/src/features/menu/data/category_data.dart';

class CategoryRepository implements ICategoryRepository {
  final ICategoryDataSource networkCategoryDataSource;
  final ISavableCategoryDataSource savableCategoryDataSource;
  const CategoryRepository(
      this.networkCategoryDataSource, this.savableCategoryDataSource);

  @override
  Future<List<CategoryData>> loadOnlyCategories() async {
    List<CategoryData> categories = [];
    try {
      categories = await networkCategoryDataSource.fetchOnlyCategories();
      for (var category in categories) {
        savableCategoryDataSource.saveCategory(category);
      }
      return categories;
    } on Exception catch (e) {
      if (e is SocketException) {
        categories = await savableCategoryDataSource.fetchOnlyCategories();
        return categories;
      }
      rethrow;
    }
  }
}
