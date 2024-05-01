import 'dart:io';

import 'package:coffee_shop/src/common/network/data_sources/category_data_source/interface_category_data_source.dart';
import 'package:coffee_shop/src/common/network/repositories/category_repository/interface_category_repository.dart';
import 'package:coffee_shop/src/features/database/data_source/savable_category_data_source.dart';
import 'package:coffee_shop/src/features/menu/data/category_dto.dart';
import 'package:coffee_shop/src/features/menu/models/category_model.dart';
import 'package:coffee_shop/src/features/menu/utils/category_mapper.dart';

class CategoryRepository implements ICategoryRepository {
  final ICategoryDataSource networkCategoryDataSource;
  final ISavableCategoryDataSource savableCategoryDataSource;
  const CategoryRepository(
      this.networkCategoryDataSource, this.savableCategoryDataSource);

  @override
  Future<List<CategoryModel>> loadOnlyCategories() async {
    List<CategoryModel> categories = [];
    try {
      final List<CategoryDTO> categoriesDTO =
          await networkCategoryDataSource.fetchOnlyCategories();
      for (var category in categoriesDTO) {
        categories.add(category.toModel());
        savableCategoryDataSource.saveCategory(category);
      }
      return categories;
    } on Exception catch (e) {
      if (e is SocketException) {
        final List<CategoryDTO> categoriesDTO =
            await savableCategoryDataSource.fetchOnlyCategories();
        categories = categoriesDTO.map((e) => e.toModel()).toList();
        return categories;
      }
      rethrow;
    }
  }
}
